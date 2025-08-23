# frozen_string_literal: true

require_relative '../../lib/pieces/knight'
require_relative '../../lib/board'

RSpec.describe Knight do
  let(:board) { Board.new }
  let(:knight) { Knight.new(:white) }

  describe '#symbol' do
    it 'returns "n"' do
      expect(knight.symbol).to eq('n')
    end
  end

  describe '#possible_moves' do
    it 'can move in L shape' do
      moves = knight.possible_moves(board, 3, 3)
      expect(moves).to include([1, 2], [1, 4], [2, 1], [2, 5], [4, 1], [4, 5], [5, 2], [5, 4])
    end

    it 'can jump over pieces' do
      board.grid[2][2] = Knight.new(:black)
      moves = knight.possible_moves(board, 3, 3)
      expect(moves).to include([1, 2])
    end

    it 'includes cell occupied by enemy piece' do
      board.grid[2][5] = Knight.new(:black)
      moves = knight.possible_moves(board, 3, 3)
      expect(moves).to include([2, 5])
    end

    it 'does not include cell occupied by friendly piece' do
      board.grid[5][2] = Knight.new(:white)
      moves = knight.possible_moves(board, 3, 3)
      expect(moves).not_to include([5, 2])
    end
  end
end
