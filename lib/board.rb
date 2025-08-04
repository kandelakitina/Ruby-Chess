# frozen_string_literal: true

require_relative 'pieces'
require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, '.') }
    # fill_board
  end

  def display
    8.downto(1) do |i|
      puts "#{i.to_s.red} #{@grid[i - 1][0..8].join(' ')}"
    end
    puts '  a b c d e f g h'
  end

  # def empty?(pos)
  #   row, col = pos
  #   in_bounds?(pos) && @grid[row][col].nil?
  # end

  # def enemy_at?(pos, color)
  #   row, col = pos
  #   return false unless in_bounds?(pos)

  #   piece = @grid[row][col]
  #   return false if piece.nil?

  #   piece.color != color
  # end

  # def in_bounds?(pos)
  #   row, col = pos
  #   row.between?(0, 7) && col.between?(0, 7)
  # end

  # private

  # def fill_board
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
