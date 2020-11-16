# frozen_string_literal: true

RSpec.describe Interpreter do
  describe '.new' do
    subject(:new) { described_class.new('parser') }

    it { is_expected.to be_a described_class::Core }
  end
end
