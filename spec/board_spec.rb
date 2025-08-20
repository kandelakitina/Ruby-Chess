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
end
