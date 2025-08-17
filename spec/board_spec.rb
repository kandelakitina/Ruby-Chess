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
end
