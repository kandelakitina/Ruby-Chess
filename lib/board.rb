# frozen_string_literal: true

require 'colorize'
require_relative 'empty_cell'
require_relative 'pieces/pawn'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptyCell.new } }

    fill_grid
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

  def fill_grid
    # Place white pieces
    @grid[0][0], @grid[0][7] = Rook.new(:white)
    @grid[0][1] = Knight.new(:white)
    @grid[0][2] = Bishop.new(:white)
    @grid[0][3] = Queen.new(:white)
    @grid[0][4] = King.new(:white)
    @grid[0][5] = Bishop.new(:white)
    @grid[0][6] = Knight.new(:white)
    @grid[0][7] = Rook.new(:white)
    8.times do |col|
      @grid[1][col] = Pawn.new(:white)
    end

    # Place black pieces
    @grid[7][0] = Rook.new(:black)
    @grid[7][1] = Knight.new(:black)
    @grid[7][2] = Bishop.new(:black)
    @grid[7][3] = Queen.new(:black)
    @grid[7][4] = King.new(:black)
    @grid[7][5] = Bishop.new(:black)
    @grid[7][6] = Knight.new(:black)
    @grid[7][7] = Rook.new(:black)
    8.times do |col|
      @grid[6][col] = Pawn.new(:black)
    end
  end
end
