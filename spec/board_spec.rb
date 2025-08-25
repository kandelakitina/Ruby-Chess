# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/pawn'

RSpec.describe Board, type: :model do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 array' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end

    it 'creates distinct EmptyCell instances (not the same object)' do
      first = board.grid[2][0] # empty row
      second = board.grid[2][1]
      expect(first).not_to be(second)
    end
  end

  describe '#empty_at?' do
    it 'returns true for an empty cell within bounds' do
      expect(board.empty_at?([2, 0])).to be true
    end

    it 'returns false for a cell occupied by a piece' do
      board.grid[1][4] = Pawn.new(:white)
      board.grid[6][4] = Pawn.new(:black)

      expect(board.empty_at?([1, 4])).to be false
      expect(board.empty_at?([6, 4])).to be false
    end

    it 'returns false for positions out of bounds' do
      expect(board.empty_at?([-1, 0])).to be false
      expect(board.empty_at?([0, 8])).to be false
    end
  end

  describe '#enemy_at?' do
    it 'returns true if there is an enemy piece at the position' do
      board.grid[1][4] = Pawn.new(:white)
      board.grid[6][4] = Pawn.new(:black)

      expect(board.enemy_at?([1, 4], :black)).to be true
      expect(board.enemy_at?([6, 4], :white)).to be true
    end

    it 'returns false for an empty cell' do
      expect(board.enemy_at?([0, 0], :white)).to be false
    end

    it 'returns false if there is a friendly piece at the position' do
      board.grid[2][2] = Knight.new(:white)
      expect(board.enemy_at?([2, 2], :white)).to be false
    end

    it 'returns false for positions out of bounds' do
      expect(board.enemy_at?([-1, 0], :white)).to be false
      expect(board.enemy_at?([8, 8], :black)).to be false
    end
  end

  describe '#move_piece' do
    before do
      board.grid[0][0] = Rook.new(:white)
    end

    it 'moves a piece from one square to another' do
      from = [0, 0]
      to = [0, 3]

      board.move_piece(from, to)

      expect(board.grid[0][3]).to be_a(Rook)
      expect(board.grid[0][3].color).to eq(:white)
      expect(board.grid[0][0]).to be_a(EmptyCell)
    end

    it 'can capture an enemy piece' do
      from = [0, 0]
      to = [0, 3]
      board.grid[0][3] = Knight.new(:black)

      board.move_piece(from, to)

      expect(board.grid[0][3]).to be_a(Rook)
      expect(board.grid[0][3].color).to eq(:white)
      expect(board.grid[0][0]).to be_a(EmptyCell)
    end

    it 'overwrites the target if occupied' do
      from = [0, 0]
      to = [0, 3]
      board.grid[0][3] = Knight.new(:white) # friendly piece

      board.move_piece(from, to)

      expect(board.grid[0][3]).to be_a(Rook) # still overwrites
      expect(board.grid[0][0]).to be_a(EmptyCell)
    end
  end
  describe '#in_bounds?' do
    it 'returns true for positions inside the grid' do
      expect(board.in_bounds?([0, 0])).to be true
      expect(board.in_bounds?([7, 7])).to be true
      expect(board.in_bounds?([3, 4])).to be true
    end

    it 'returns false for positions outside the grid' do
      expect(board.in_bounds?([-1, 0])).to be false
      expect(board.in_bounds?([0, -1])).to be false
      expect(board.in_bounds?([8, 0])).to be false
      expect(board.in_bounds?([0, 8])).to be false
    end
  end

  describe '#piece_at' do
    before do
      board.grid[0][0] = Pawn.new(:white)
    end

    it 'returns the piece at a valid position' do
      piece = board.piece_at([0, 0])
      expect(piece).to be_a(Pawn)
      expect(piece.color).to eq(:white)
    end

    it 'returns an EmptyCell if the square is empty' do
      expect(board.piece_at([1, 1])).to be_a(EmptyCell)
    end

    it 'returns nil for positions out of bounds' do
      expect(board.piece_at([-1, 0])).to be_nil
      expect(board.piece_at([0, 8])).to be_nil
    end
  end
end
