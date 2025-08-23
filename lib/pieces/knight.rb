# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def symbol
    'n'
  end

  def possible_moves(board, row, col)
    moves = []

    offsets = [
      [-2, -1], [-2, 1],
      [-1, -2], [-1, 2],
      [1, -2],  [1, 2],
      [2, -1],  [2, 1]
    ]

    offsets.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc
      next unless board.in_bounds?([new_row, new_col])

      target = board.grid[new_row][new_col]

      moves << [new_row, new_col] if target.empty? || target.color != color
    end

    moves
  end
end
