# frozen_string_literal: true

require 'interpreter/token'

RSpec.describe Interpreter::Token do
  subject(:token) { described_class.new(type, value) }

  let(:type) { :integer }
  let(:value) { 4 }

  describe '#initialize' do
    it 'has a type and a value', :aggregate_failures do
      expect(token.type).to eq :integer
      expect(token.value).to eq 4
    end
  end

  describe '#str' do
    subject(:str) { token.str }

    it { is_expected.to eq 'Token(integer, 4)' }
  end
end
