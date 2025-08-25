# frozen_string_literal: true

require_relative 'player'

class AI < Player
  def take_turn(board)
    # For now: pick a random legal move
    all_moves = []

    (0..7).each do |row|
      (0..7).each do |col|
        piece = board.grid[row][col]
        next if piece.empty? || piece.color != color

        moves = piece.possible_moves(board, row, col)
        moves.each do |to|
          all_moves << [[row, col], to]
        end
      end
    end

    all_moves.sample
  end
end
