# frozen_string_literal: true

require 'interpreter/parser'
require 'support/helpers/token'
require 'support/shared_context/lexer'

RSpec.describe Interpreter::Parser do
  subject(:parser) { described_class.new(lexer) }

  describe '#parse' do
    subject(:parse) { parser.parse }

    {
      addition: { type: :plus, value: '+', result: 12 },
      subtraction: { type: :minus, value: '-', result: 6 },
      multiplication: { type: :multiply, value: '*', result: 27 },
      division: { type: :divide, value: '/', result: 3 }
    }.each do |operation, token|
      context "when #{operation}" do
        include_context 'lexer' do
          let(:tokens) do
            [
              mocked_integer_token(9),
              mocked_token(token[:type], token[:value]),
              mocked_integer_token(3),
              mocked_eof_token
            ]
          end
        end

        it { is_expected.to eq token[:result] }
      end
    end

    context 'with arbitrary number of tokens' do
      include_context 'lexer' do
        let(:tokens) do
          [
            mocked_integer_token(14),
            mocked_plus_token,
            mocked_integer_token(2),
            mocked_multiply_token,
            mocked_integer_token(3),
            mocked_minus_token,
            mocked_integer_token(6),
            mocked_divide_token,
            mocked_integer_token(2),
            mocked_eof_token
          ]
        end
      end

      it { is_expected.to eq 17 }
    end

    context 'with an invalid token' do
      include_context 'lexer' do
        let(:tokens) { [mocked_token(:invalid, 9)] }
      end

      it { expect { parse }.to raise_error described_class::ParserError }
    end
  end
end
