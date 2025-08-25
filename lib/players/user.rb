# frozen_string_literal: true

require_relative 'player'

class User < Player
  def take_turn(board)
    puts "#{name} (#{color}), it's your move."
    loop do
      print "Enter move (e.g., 'e2 e4'): "
      input = gets.chomp
      from_str, to_str = input.split

      from = algebraic_to_pos(from_str)
      to   = algebraic_to_pos(to_str)

      piece = board.piece_at(from)

      if piece.empty?
        puts "No piece at #{from_str}. Try again."
        next
      elsif piece.color != color
        puts "That's not your piece. Try again."
        next
      elsif !piece.possible_moves(board, *from).include?(to)
        puts 'Illegal move. Try again.'
        next
      end

      return [from, to]
    end
  end

  private

  # convert "e2" -> [6, 4]
  def algebraic_to_pos(str)
    col = str[0].ord - 'a'.ord
    row = 8 - str[1].to_i
    [row, col]
  end
end
