# frozen_string_literal: true

require 'rspec'
require_relative '../lib/board'

RSpec.describe Board, type: :model do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.length == 8 }).to be true
    end
  end

  # describe '#empty?' do
  #   context 'when position is empty' do
  #     it 'returns true' do
  #       expect(board.empty?([0, 0])).to be true
  #     end
  #   end
  # end

  # describe '#enemy_at?' do
  #   it 'returns false if no enemy piece at position' do
  #     expect(board.enemy_at?([0, 0], :white)).to be false
  #   end
  # end

  # describe '#in_bounds?' do
  #   it 'returns true for in-bounds position' do
  #     expect(board.in_bounds?([0, 0])).to be true
  #   end
  #   it 'returns false for out-of-bounds position' do
  #     expect(board.in_bounds?([8, 8])).to be false
  #   end
  # end
end
