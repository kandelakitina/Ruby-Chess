# frozen_string_literal: true

require_relative 'board'
require_relative 'user'
require_relative 'ai'
require_relative 'pieces'

class Game
  def initialize
    @board = Board.new
    @player = User.new
    @ai = Ai.new
  end

  def play
    until game_over?
      @board.display

      move = @player.take_turn(@board)
      apply_move(move)

      break if game_over?

      move = @ai.take_turn(@board)
      apply_move(move)
    end
  end

  def userturn; end

  def aiturn; end

  private

  def game_over?; end
end
