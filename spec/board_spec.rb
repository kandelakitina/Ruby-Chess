# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board, type: :model do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 array' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end

    it 'creates distinct objects for each grid cell' do
      flattened = board.grid.flatten

      # Only compare EmptyCell objects to ensure they are distinct
      empty_cells = flattened.select { |cell| cell.is_a?(EmptyCell) }

      # Expect all EmptyCell instances to be unique objects
      empty_cells.combination(2).each do |cell1, cell2|
        expect(cell1).not_to be(cell2)
      end
    end

    it 'creates distinct EmptyCell instances (not the same object)' do
      first = board.grid[0][0]
      second = board.grid[0][1]
      expect(first).not_to be(second)
    end
  end

  describe '#empty_at?' do
    it 'returns true for an empty cell within bounds' do
      expect(board.empty_at?([0, 0])).to be true
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
