# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def symbol
    'b'
  end

  def possible_moves(board, row, col)
    moves = []

    # Diagonals: top-right, top-left, bottom-right, bottom-left
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

    directions.each do |row_dir, col_dir|
      r = row + row_dir
      c = col + col_dir
      while board.in_bounds?([r, c]) && board.empty_at?([r, c])
        moves << [r, c]
        r += row_dir
        c += col_dir
      end

      # Capture logic
      moves << [r, c] if board.in_bounds?([r, c]) && board.enemy_at?([r, c], color)
    end

    moves
  end
end
