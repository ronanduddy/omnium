# frozen_string_literal: true

require 'interpreter/operators'

RSpec.describe Interpreter::Operators do
  let(:object) { Class.new.include(described_class).new }

  describe '#operator?' do
    subject(:operator?) { object.operator?(character) }

    context 'with valid operator' do
      let(:character) { '+' }

      it { is_expected.to be true }
    end

    context 'with invalid operator' do
      let(:character) { ']' }

      it { is_expected.to be false }
    end
  end
end
