# frozen_string_literal: true

require 'interpreter/lexer'

RSpec.describe Interpreter::Lexer do
  subject(:lexer) { described_class.new(text) }

  let(:text) { '1+1' }

  describe '#evaluate' do
    subject(:evaluate) { lexer.evaluate }

    context 'with valid text' do
      it { is_expected.to eq 2 }
    end

    context 'with text containing alpha character' do
      let(:text) { '1+a' }

      it { expect { evaluate }.to raise_error(described_class::LexerError) }
    end

    context 'with text containing spaces' do
      let(:text) { '1 + 1' }

      it { is_expected.to eq 2 }
    end

    context 'with text containing large numbers' do
      let(:text) { '1111 + 1111' }

      it { is_expected.to eq 2222 }
    end

    context 'with text subtracting' do
      let(:text) { '1-1' }

      it { is_expected.to eq 0 }
    end

    context 'with text multiplying' do
      let(:text) { '3 * 2' }

      it { is_expected.to eq 6 }
    end

    context 'with text dividing' do
      let(:text) { '4/2' }

      it { is_expected.to eq 2 }
    end
  end
end
