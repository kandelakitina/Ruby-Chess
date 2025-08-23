# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def symbol
    'r'
  end

  def possible_moves(board, row, col)
    moves = []

    # straight directions: vertical and horizontal
    directions = [
      [1, 0],  # down
      [-1, 0], # up
      [0, 1],  # right
      [0, -1]  # left
    ]

    directions.each do |dr, dc|
      r = row
      c = col

      loop do
        r += dr
        c += dc
        break unless board.in_bounds?([r, c])

        target = board.grid[r][c]

        if target.empty?
          moves << [r, c]
        elsif target.color != color
          moves << [r, c] # can capture enemy
          break
        else
          break # friendly piece blocks
        end
      end
    end

    moves
  end
end
