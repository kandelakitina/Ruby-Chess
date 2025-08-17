# frozen_string_literal: true

require 'rspec'
require_relative '../lib/empty_cell'

RSpec.describe EmptyCell do
  subject(:cell) { described_class.new }

  describe '#to_s' do
    it 'returns a dot' do
      expect(cell.to_s).to eq('.')
    end
  end

  describe '#empty?' do
    it 'returns true' do
      expect(cell.empty?).to be true
    end
  end
end
