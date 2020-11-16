# frozen_string_literal: true

RSpec.describe Lexer do
  describe '.new' do
    subject(:new) { described_class.new('text') }

    it { is_expected.to be_a described_class::Core }
  end
end
