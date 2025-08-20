# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def symbol
    'n'
  end

  # def possible_moves(board, row, col)
  #   moves = []

  #   direction = color == :white ? 1 : -1
  #   start_row = color == :white ? 1 : 6

  #   # 1. Forward one
  #   one_ahead = [row + direction, col]
  #   moves << one_ahead if board.empty_at?(one_ahead)

  #   # 2. Forward two from starting row
  #   two_ahead = [row + (2 * direction), col]
  #   moves << two_ahead if row == start_row && board.empty_at?(one_ahead) && board.empty_at?(two_ahead)

  #   # 3. Diagonal captures
  #   [[row + direction, col + 1], [row + direction, col - 1]].each do |r, c|
  #     moves << [r, c] if board.enemy_at?([r, c], color)
  #   end

  #   moves
  # end
end
