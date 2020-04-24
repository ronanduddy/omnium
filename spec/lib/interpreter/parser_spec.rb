# frozen_string_literal: true

require 'interpreter/parser'
require 'support/helpers/token'

RSpec.describe Interpreter::Parser do
  subject(:parser) { described_class.new(tokens) }

  describe '#parse' do
    subject(:evaluate) { parser.parse }

    {
      addition: { type: :plus, value: '+', result: 12 },
      subtraction: { type: :minus, value: '-', result: 6 },
      multiplication: { type: :multiply, value: '*', result: 27 },
      division: { type: :divide, value: '/', result: 3 }
    }.each do |operation, token|
      context "when #{operation}" do
        let(:tokens) do
          [
            new_token(:integer, 9),
            new_token(token[:type], token[:value]),
            new_token(:integer, 3),
            new_token(:eof, nil)
          ]
        end

        it 'returns the correct hash' do
          is_expected.to eq token[:result]
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
          new_token(:integer, 1),
          new_token(:eof, nil)
        ]
      end

      it 'returns the correct hash' do
        is_expected.to eq 7
      end
    end

    context 'with an invalid token' do
      let(:tokens) do
        [
          new_token(:invalid, 9),
          new_token(:minus, '-'),
          new_token(:integer, 3),
          new_token(:eof, nil)
        ]
      end

      it { expect { evaluate }.to raise_error described_class::ParserError }
    end
  end
end
