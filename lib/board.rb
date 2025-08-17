# frozen_string_literal: true

require 'colorize'
require_relative 'empty_cell'
require_relative 'pieces/pawn'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptyCell.new } }

    # TODO: - move to #fillgrid
    @grid[1][4] = Pawn.new(:white)
    @grid[6][4] = Pawn.new(:black)
  end

  def display
    8.downto(1) do |i|
      row = @grid[i - 1]
      symbols = row.map(&:to_s)
      puts "#{i.to_s.red} #{symbols.join(' ')}"
    end
    puts '  a b c d e f g h'.green
  end

  def empty_at?(pos)
    row, col = pos
    in_bounds?(pos) && @grid[row][col].empty?
  end

  def enemy_at?(pos, color)
    row, col = pos
    in_bounds?(pos) && !@grid[row][col].empty? && @grid[row][col].color != color
  end

  private

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  # def fill_grid
  #   # Place white pawns on row 1
  #   8.times do |col|
  #     @grid[1][col] = Pawn.new(:white, [1, col])
  #   end

  #   # Place black pawns on row 6
  #   8.times do |col|
  #     @grid[6][col] = Pawn.new(:black, [6, col])
  #   end
  # end
end
