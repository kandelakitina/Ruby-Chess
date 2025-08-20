# frozen_string_literal: true

require_relative '../lib/board'

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

    it 'places 16 white pieces and 16 black pieces' do
      flattened = board.grid.flatten
      white_pieces = flattened.count { |cell| cell.is_a?(Piece) && cell.color == :white }
      black_pieces = flattened.count { |cell| cell.is_a?(Piece) && cell.color == :black }

      expect(white_pieces).to eq(16)
      expect(black_pieces).to eq(16)
    end

    it 'places pawns in the correct rows' do
      expect(board.grid[1].all? { |cell| cell.is_a?(Pawn) && cell.color == :white }).to be true
      expect(board.grid[6].all? { |cell| cell.is_a?(Pawn) && cell.color == :black }).to be true
    end

    it 'places rooks, knights, bishops, queen, and king in the correct positions' do
      # White back rank
      expect(board.grid[0][0]).to be_a(Rook).and have_attributes(color: :white)
      expect(board.grid[0][1]).to be_a(Knight).and have_attributes(color: :white)
      expect(board.grid[0][2]).to be_a(Bishop).and have_attributes(color: :white)
      expect(board.grid[0][3]).to be_a(Queen).and have_attributes(color: :white)
      expect(board.grid[0][4]).to be_a(King).and have_attributes(color: :white)

      # Black back rank
      expect(board.grid[7][0]).to be_a(Rook).and have_attributes(color: :black)
      expect(board.grid[7][1]).to be_a(Knight).and have_attributes(color: :black)
      expect(board.grid[7][2]).to be_a(Bishop).and have_attributes(color: :black)
      expect(board.grid[7][3]).to be_a(Queen).and have_attributes(color: :black)
      expect(board.grid[7][4]).to be_a(King).and have_attributes(color: :black)
    end
  end

  describe '#empty_at?' do
    it 'returns true for an empty cell within bounds' do
      expect(board.empty_at?([2, 0])).to be true
    end

    it 'returns false for a cell occupied by a piece' do
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
      expect(board.enemy_at?([1, 4], :black)).to be true
      expect(board.enemy_at?([6, 4], :white)).to be true
    end

    it 'returns false if the piece is the same color' do
      expect(board.enemy_at?([1, 4], :white)).to be false
      expect(board.enemy_at?([6, 4], :black)).to be false
    end

    it 'returns false for an empty cell' do
      expect(board.enemy_at?([0, 0], :white)).to be false
    end

    it 'returns false for positions out of bounds' do
      expect(board.enemy_at?([-1, 0], :white)).to be false
      expect(board.enemy_at?([8, 8], :black)).to be false
    end
  end
end
