# frozen_string_literal: true

RSpec.describe Lexer::Token do
  subject(:token) { described_class.new(type, value) }

  let(:type) { :integer }
  let(:value) { 4 }

  describe '#initialize' do
    it { is_expected.to have_attributes(type: :integer, value: 4) }
  end
end
