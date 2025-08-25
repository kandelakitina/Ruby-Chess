# frozen_string_literal: true

require_relative '../../lib/players/player'

RSpec.describe Player do
  describe '#initialize' do
    it 'sets color and default name' do
      player = Player.new(:white)
      expect(player.color).to eq(:white)
      expect(player.name).to eq('White')
    end

    it 'allows custom name' do
      player = Player.new(:black, 'AI Bot')
      expect(player.color).to eq(:black)
      expect(player.name).to eq('AI Bot')
    end
  end

  describe '#take_turn' do
    it 'raises NotImplementedError' do
      player = Player.new(:white)
      board = double('board') # simple test double
      expect { player.take_turn(board) }.to raise_error(NotImplementedError)
    end
  end
end
