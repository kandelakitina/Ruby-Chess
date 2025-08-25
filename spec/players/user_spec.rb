# frozen_string_literal: true

require_relative '../../lib/players/user'
require_relative '../../lib/board'
require_relative '../../lib/pieces/pawn'

RSpec.describe User do
  let(:board) { Board.new }
  let(:user) { User.new(:white, 'Alice') }

  before do
    # Place a white pawn at e2 ([6,4])
    board.grid[6][4] = Pawn.new(:white)
  end

  # describe '#take_turn' do
  #   it 'returns a valid move when user enters a correct move' do
  #     # Mock input: user types "e2 e4"
  #     allow(user).to receive(:gets).and_return('e2 e4')
  #     allow($stdout).to receive(:puts)
  #     allow($stdout).to receive(:print)

  #     move = user.take_turn(board)
  #     expect(move).to eq([[6, 4], [4, 4]]) # e2 -> e4
  #   end

  #   it 'rejects move from empty square and asks again' do
  #     allow(user).to receive(:gets).and_return('a3 a4', 'e2 e4')
  #     allow($stdout).to receive(:puts)
  #     allow($stdout).to receive(:print)

  #     move = user.take_turn(board)
  #     expect(move).to eq([[6, 4], [4, 4]]) # e2 -> e4
  #   end

  #   it 'rejects move of opponent piece and asks again' do
  #     board.grid[1][0] = Pawn.new(:black) # black pawn at a7
  #     allow(user).to receive(:gets).and_return('a7 a6', 'e2 e4')
  #     allow($stdout).to receive(:puts)
  #     allow($stdout).to receive(:print)

  #     move = user.take_turn(board)
  #     expect(move).to eq([[6, 4], [4, 4]])
  #   end

  #   it 'rejects illegal move and asks again' do
  #     allow(user).to receive(:gets).and_return('e2 e5', 'e2 e4')
  #     allow($stdout).to receive(:puts)
  #     allow($stdout).to receive(:print)

  #     move = user.take_turn(board)
  #     expect(move).to eq([[6, 4], [4, 4]])
  #   end
  # end
end
