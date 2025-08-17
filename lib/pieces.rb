# frozen_string_literal: true

class Piece
  attr_reader :color

  def initialize(color)
    @color = color # :white or :black
  end

  def empty?
    false
  end

  def symbol
    raise NotImplementedError, 'Subclasses must define a symbol'
  end

  def to_s
    if color == :white
      symbol.upcase
    else
      symbol.downcase
    end
  end
end
