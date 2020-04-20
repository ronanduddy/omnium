# frozen_string_literal: true

require 'interpreter/parser'
require 'support/helpers/token'

RSpec.describe Interpreter::Parser do
  subject(:parser) { described_class.new(tokens) }

  describe '#evaluate' do
    subject(:evaluate) { parser.evaluate }

    {
      addition: { type: :plus, value: '+' },
      subtraction: { type: :minus, value: '-' },
      multiplication: { type: :multiply, value: '*' },
      division: { type: :divide, value: '/' }
    }.each do |operation, token|
      context "with #{operation}" do
        let(:tokens) do
          [
            new_token(:integer, 9),
            new_token(token[:type], token[:value]),
            new_token(:integer, 3)
          ]
        end

        it 'returns the correct hash' do
          is_expected.to eq [9, token[:value], 3]
        end
      end
    end

    context 'with arbitrary number of tokens' do
      let(:tokens) do
        [
          new_token(:integer, 9),
          new_token(:minus, '-'),
          new_token(:integer, 3),
          new_token(:plus, '+'),
          new_token(:integer, 1)
        ]
      end

      it 'returns the correct hash' do
        is_expected.to eq [9, '-', 3, '+', 1]
      end
    end

    context 'with invalid tokens' do
      let(:tokens) do
        [
          new_token(:invalid, 9),
          new_token(:minus, '-'),
          new_token(:integer, 3)
        ]
      end

      it { expect { evaluate }.to raise_error described_class::ParserError }
    end
  end
end
