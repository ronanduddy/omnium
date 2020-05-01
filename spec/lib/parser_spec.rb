# frozen_string_literal: true

require 'parser'
require 'support/helpers/token_helper'
require 'support/shared_context/lexer'

RSpec.describe Parser do
  subject(:parser) { described_class.new(lexer) }

  describe '#parse' do
    subject(:parse) { parser.parse }

    context 'without parentheses' do
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

    context 'with parentheses' do
      include_context 'lexer' do
        let(:tokens) do
          [
            mocked_integer_token(7),
            mocked_plus_token,
            mocked_integer_token(3),
            mocked_multiply_token,
            mocked_left_parenthesis_token,
            mocked_integer_token(10),
            mocked_divide_token,
            mocked_left_parenthesis_token,
            mocked_integer_token(12),
            mocked_divide_token,
            mocked_left_parenthesis_token,
            mocked_integer_token(3),
            mocked_plus_token,
            mocked_integer_token(1),
            mocked_right_parenthesis_token,
            mocked_minus_token,
            mocked_integer_token(1),
            mocked_right_parenthesis_token,
            mocked_right_parenthesis_token,
            mocked_eof_token
          ]
        end
      end

      it { is_expected.to eq 22 }
    end
  end
end
