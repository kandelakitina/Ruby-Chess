# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/king'

RSpec.describe Game do
  let(:game) { Game.new }
  let(:board) do
    game.fill_grid
    game.board
  end

  describe '#fill_board' do
    it 'places 16 white pieces and 16 black pieces' do
      flattened = board.grid.flatten
      white_pieces = flattened.count { |cell| cell.is_a?(Piece) && cell.color == :white }
      black_pieces = flattened.count { |cell| cell.is_a?(Piece) && cell.color == :black }

      expect(white_pieces).to eq(16)
      expect(black_pieces).to eq(16)
    end

    it 'places pawns in the correct rows' do
      expect(board.grid[1].all? { |cell| cell.is_a?(Pawn) && cell.color == :white }).to be true
      expect(board.grid[6].all? { |cell| cell.is_a?(Pawn) && cell.color == :black }).to be true
    end

    it 'places rooks, knights, bishops, queen, and king in the correct positions' do
      # White back rank
      expect(board.grid[0][0]).to be_a(Rook).and have_attributes(color: :white)
      expect(board.grid[0][1]).to be_a(Knight).and have_attributes(color: :white)
      expect(board.grid[0][2]).to be_a(Bishop).and have_attributes(color: :white)
      expect(board.grid[0][3]).to be_a(Queen).and have_attributes(color: :white)
      expect(board.grid[0][4]).to be_a(King).and have_attributes(color: :white)

      # Black back rank
      expect(board.grid[7][0]).to be_a(Rook).and have_attributes(color: :black)
      expect(board.grid[7][1]).to be_a(Knight).and have_attributes(color: :black)
      expect(board.grid[7][2]).to be_a(Bishop).and have_attributes(color: :black)
      expect(board.grid[7][3]).to be_a(Queen).and have_attributes(color: :black)
      expect(board.grid[7][4]).to be_a(King).and have_attributes(color: :black)
    end
  end
end
