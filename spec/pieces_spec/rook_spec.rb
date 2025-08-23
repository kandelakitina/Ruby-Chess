# frozen_string_literal: true

require_relative '../../lib/pieces/rook'
require_relative '../../lib/board'

RSpec.describe Rook do
  let(:board) { Board.new }
  let(:rook) { Rook.new(:white) }

  describe '#symbol' do
    it 'returns "r"' do
      expect(rook.symbol).to eq('r')
    end
  end

  describe '#possible_moves' do
    it 'can move horizontally and vertically if path is clear' do
      moves = rook.possible_moves(board, 3, 3)
      expect(moves).to include([3, 0], [3, 7], [0, 3], [7, 3])
    end

    it 'cannot jump over pieces' do
      board.grid[3][1] = Rook.new(:black)
      moves = rook.possible_moves(board, 3, 0)
      expect(moves).not_to include([3, 2])
    end

    it 'stops at occupied cell with enemy piece' do
      board.grid[4][3] = Rook.new(:black)
      moves = rook.possible_moves(board, 3, 3)
      expect(moves).to include([4, 3])
    end

    it 'does not include occupied cell with friendly piece' do
      board.grid[4][3] = Rook.new(:white)
      moves = rook.possible_moves(board, 3, 3)
      expect(moves).not_to include([4, 3])
    end
  end
end
