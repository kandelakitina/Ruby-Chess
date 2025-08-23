# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  def symbol
    'q'
  end

  def possible_moves(board, row, col)
    moves = []

    directions = [
      [1, 0], [-1, 0],  # vertical
      [0, 1], [0, -1],  # horizontal
      [1, 1], [1, -1],  # diagonals
      [-1, 1], [-1, -1]
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
          moves << [r, c]
          break
        else
          break
        end
      end
    end

    moves
  end
end
