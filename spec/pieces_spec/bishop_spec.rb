# frozen_string_literal: true

require_relative '../../lib/pieces/bishop'
require_relative '../../lib/board'

RSpec.describe Bishop do
  let(:board) { Board.new }
  let(:bishop) { Bishop.new(:white) }

  describe '#symbol' do
    it 'returns "b"' do
      expect(bishop.symbol).to eq('b')
    end
  end

  describe '#possible_moves' do
    it 'can move diagonally if path is clear' do
      moves = bishop.possible_moves(board, 0, 2)
      expect(moves).to include([1, 3], [2, 4])
    end

    it 'cannot jump over pieces' do
      board.grid[1][3] = Bishop.new(:black)
      moves = bishop.possible_moves(board, 0, 2)
      expect(moves).not_to include([2, 4])
    end

    it 'stops at occupied cell with enemy piece' do
      board.grid[2][4] = Bishop.new(:black)
      moves = bishop.possible_moves(board, 0, 2)
      expect(moves).to include([2, 4])
    end

    it 'does not include occupied cell with friendly piece' do
      board.grid[2][4] = Bishop.new(:white)
      moves = bishop.possible_moves(board, 0, 2)
      expect(moves).not_to include([2, 4])
    end
  end
end
