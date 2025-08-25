# frozen_string_literal: true

class Player
  attr_reader :color, :name

  def initialize(color, name = nil)
    @color = color
    @name = name || color.to_s.capitalize
  end

  # Every player must define how to choose a move
  def take_turn(board)
    raise NotImplementedError, 'Subclasses must implement #take_turn'
  end
end
