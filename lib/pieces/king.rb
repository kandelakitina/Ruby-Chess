# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def symbol
    'k'
  end

  def possible_moves(board, row, col)
    moves = []

    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    directions.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc
      next unless board.in_bounds?([new_row, new_col])

      target = board.grid[new_row][new_col]

      # King can move if cell is empty or occupied by enemy
      moves << [new_row, new_col] if target.empty? || target.color != color
    end

    moves
  end
end
