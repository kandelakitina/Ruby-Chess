# frozen_string_literal: true

require_relative '../../lib/pieces/queen'
require_relative '../../lib/board'

RSpec.describe Queen do
  let(:board) { Board.new }
  let(:queen) { Queen.new(:white) }

  describe '#symbol' do
    it 'returns "q"' do
      expect(queen.symbol).to eq('q')
    end
  end

  describe '#possible_moves' do
    it 'can move in straight lines and diagonally if path is clear' do
      moves = queen.possible_moves(board, 3, 3)
      expect(moves).to include([4, 4], [5, 5], [2, 3], [3, 2], [3, 4])
    end

    it 'stops before a friendly piece and cannot move past' do
      board.grid[1][3] = Queen.new(:white) # friendly directly in diagonal path
      moves = queen.possible_moves(board, 0, 2)

      expect(moves).not_to include([1, 3]) # cannot capture friendly
      expect(moves).not_to include([2, 4]) # cannot jump past
    end

    it 'stops at an enemy piece and can capture it, but not move past' do
      board.grid[1][3] = Queen.new(:black) # enemy directly in diagonal path
      moves = queen.possible_moves(board, 0, 2)

      expect(moves).to include([1, 3])     # can capture
      expect(moves).not_to include([2, 4]) # cannot move past
    end

    it 'includes an enemy piece in straight path but not beyond' do
      board.grid[2][4] = Queen.new(:black)
      moves = queen.possible_moves(board, 0, 2)

      expect(moves).to include([2, 4])     # can capture
      expect(moves).not_to include([3, 5]) # cannot jump past
    end

    it 'does not include a friendly piece in straight path or beyond' do
      board.grid[2][4] = Queen.new(:white)
      moves = queen.possible_moves(board, 0, 2)

      expect(moves).not_to include([2, 4]) # cannot capture friendly
      expect(moves).not_to include([3, 5]) # cannot jump past
    end
  end
end
