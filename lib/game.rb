# frozen_string_literal: true

require_relative 'board'

require_relative 'players/user'
# require_relative 'players/ai'

require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/pawn'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    fill_grid
  end

  def fill_grid
    grid = @board.grid

    # Place white pieces
    grid[0][0] = Rook.new(:white)
    grid[0][1] = Knight.new(:white)
    grid[0][2] = Bishop.new(:white)
    grid[0][3] = Queen.new(:white)
    grid[0][4] = King.new(:white)
    grid[0][5] = Bishop.new(:white)
    grid[0][6] = Knight.new(:white)
    grid[0][7] = Rook.new(:white)

    8.times do |col|
      grid[1][col] = Pawn.new(:white)
    end

    # Place black pieces
    grid[7][0] = Rook.new(:black)
    grid[7][1] = Knight.new(:black)
    grid[7][2] = Bishop.new(:black)
    grid[7][3] = Queen.new(:black)
    grid[7][4] = King.new(:black)
    grid[7][5] = Bishop.new(:black)
    grid[7][6] = Knight.new(:black)
    grid[7][7] = Rook.new(:black)

    8.times do |col|
      grid[6][col] = Pawn.new(:black)
    end
  end

  def play
    # until game_over?
    @board.display

    from, to = @player.take_turn(@board)
    @board.move_piece(from, to)

    # break if game_over?

    # move = @ai.take_turn(@grid)
    # apply_move(move)
    # end
  end

  # def userturn; end

  # def aiturn; end

  # private

  # def game_over?; end
end
