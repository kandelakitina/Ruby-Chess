# frozen_string_literal: true

require_relative '../../lib/pieces/king'
require_relative '../../lib/board'

RSpec.describe King do
  let(:board) { Board.new }
  let(:king) { King.new(:white) }

  describe '#symbol' do
    it 'returns "k"' do
      expect(king.symbol).to eq('k')
    end
  end

  describe '#possible_moves' do
    it 'can move one square in any direction' do
      moves = king.possible_moves(board, 3, 3)
      expect(moves).to include([3, 4], [4, 4], [4, 3], [4, 2], [3, 2], [2, 2], [2, 3], [2, 4])
    end

    it 'does not move into squares occupied by friendly pieces' do
      board.grid[3][4] = King.new(:white)
      moves = king.possible_moves(board, 3, 3)
      expect(moves).not_to include([3, 4])
    end

    it 'can capture enemy pieces' do
      board.grid[3][4] = King.new(:black)
      moves = king.possible_moves(board, 3, 3)
      expect(moves).to include([3, 4])
    end

    it 'cannot move more than one square' do
      moves = king.possible_moves(board, 3, 3)
      expect(moves).not_to include([5, 5], [1, 1], [0, 2], [6, 6])
    end
  end
end
