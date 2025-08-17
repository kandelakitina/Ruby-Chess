# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board, type: :model do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 array' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true
    end

    it 'fills the grid with EmptyCell objects' do
      expect(board.grid.flatten).to all(be_a(EmptyCell))
    end

    it 'creates distinct EmptyCell instances (not the same object)' do
      first = board.grid[0][0]
      second = board.grid[0][1]
      expect(first).not_to be(second)
    end
  end
end
