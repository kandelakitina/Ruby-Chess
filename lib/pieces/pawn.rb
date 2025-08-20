# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def symbol
    'p'
  end

  def possible_moves(board, row, col)
    moves = []

    direction = color == :white ? 1 : -1
    start_row = color == :white ? 1 : 6

    # 1. Forward one
    one_ahead = [row + direction, col]
    moves << one_ahead if board.in_bounds?(one_ahead) && board.empty_at?(one_ahead)

    # 2. Forward two from starting row
    two_ahead = [row + (2 * direction), col]
    if row == start_row && board.in_bounds?(two_ahead) &&
       board.empty_at?(one_ahead) && board.empty_at?(two_ahead)
      moves << two_ahead
    end

    # 3. Diagonal captures
    [[row + direction, col + 1], [row + direction, col - 1]].each do |r, c|
      target = [r, c]
      moves << target if board.in_bounds?(target) && board.enemy_at?(target, color)
    end

    moves
  end
end
