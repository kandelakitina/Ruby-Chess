# frozen_string_literal: true

require_relative '../../lib/pieces/piece'

RSpec.describe Piece do
  let(:white_piece_class) do
    Class.new(Piece) do
      def symbol
        'p'
      end
    end
  end

  let(:black_piece_class) do
    Class.new(Piece) do
      def symbol
        'p'
      end
    end
  end

  let(:white_piece) { white_piece_class.new(:white) }
  let(:black_piece) { black_piece_class.new(:black) }
  let(:abstract_piece) { Piece.new(:white) }

  describe '#initialize' do
    it 'sets the color' do
      expect(white_piece.color).to eq(:white)
      expect(black_piece.color).to eq(:black)
    end
  end

  describe '#empty?' do
    it 'returns false' do
      expect(white_piece.empty?).to be false
    end
  end

  describe '#symbol' do
    it 'raises NotImplementedError when not overridden' do
      expect { abstract_piece.symbol }.to raise_error(NotImplementedError, 'Subclasses must define a symbol')
    end

    it 'returns the subclass-defined symbol' do
      expect(white_piece.symbol).to eq('p')
    end
  end

  describe '#to_s' do
    it 'returns uppercase symbol for white pieces' do
      expect(white_piece.to_s).to eq('P')
    end

    it 'returns lowercase symbol for black pieces' do
      expect(black_piece.to_s).to eq('p')
    end
  end
end
