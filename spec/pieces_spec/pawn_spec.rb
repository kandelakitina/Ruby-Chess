# spec/pieces/pawn_spec.rb
# frozen_string_literal: true

require_relative '../../lib/pieces/pawn'
require_relative '../../lib/board'

RSpec.describe Pawn do
  let(:board) { Board.new }

  describe '#symbol' do
    it 'returns "p"' do
      pawn = Pawn.new(:white)
      expect(pawn.symbol).to eq('p')
    end
  end

  describe '#possible_moves' do
    context 'white pawn at starting row' do
      let(:pawn) { Pawn.new(:white) }

      it 'can move one or two forward if path is clear' do
        moves = pawn.possible_moves(board, 1, 3)
        expect(moves).to include([2, 3], [3, 3])
      end

      it 'cannot move two forward if blocked' do
        board.grid[2][3] = Pawn.new(:black)
        moves = pawn.possible_moves(board, 1, 3)
        expect(moves).to eq([]) # pawn blocked, no forward move
      end
    end

    context 'black pawn at starting row' do
      let(:pawn) { Pawn.new(:black) }

      it 'can move one or two forward if path is clear' do
        moves = pawn.possible_moves(board, 6, 4)
        expect(moves).to include([5, 4], [4, 4])
      end
    end

    context 'pawn diagonal captures' do
      let(:pawn) { Pawn.new(:white) }

      it 'includes diagonal enemy positions' do
        board.grid[2][2] = Pawn.new(:black)
        board.grid[2][4] = Pawn.new(:black)
        moves = pawn.possible_moves(board, 1, 3)
        expect(moves).to include([2, 2], [2, 4])
      end

      it 'does not include diagonal friendly pieces' do
        board.grid[2][2] = Pawn.new(:white)
        moves = pawn.possible_moves(board, 1, 3)
        expect(moves).not_to include([2, 2])
      end
    end

    context 'pawn blocked directly ahead' do
      let(:pawn) { Pawn.new(:white) }

      it 'cannot move forward if the cell ahead is occupied' do
        board.grid[2][3] = Pawn.new(:black)
        moves = pawn.possible_moves(board, 1, 3)
        expect(moves).not_to include([2, 3], [3, 3])
      end
    end
  end
end
