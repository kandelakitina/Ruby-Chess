# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  MOVES_WHITE = [[1, 0], [2, 0], [1, 1], [1, -1]].freeze
  MOVES_BLACK = [[-1, 0], [-2, 0], [-1, 1], [-1, -1]].freeze

  def initialize(color)
    super
    @moves = color == :white ? MOVES_WHITE : MOVES_BLACK
  end

  def symbol
    'p'
  end
end
