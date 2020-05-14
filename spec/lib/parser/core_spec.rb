# frozen_string_literal: true

require 'common'
require 'lexer'
require 'parser'
require 'support/helpers/lexer_helper'
require 'support/helpers/token_helper'
require 'support/helpers/ast_node_helpers'
require 'support/matchers/ast'

RSpec.describe Parser::Core do
  subject(:parser) { described_class.new(lexer(input)) }

  describe '#parse' do
    subject(:parse) { parser.parse }

    context 'when unary operator' do
      context 'with no parentheses' do
        let(:input) { '5 - - - 2' }

        let(:tree) do
          binary_operator_node(
            left: number_node(integer_token(5)),
            operator: minus_token,
            right: unary_operator_node(
              operator: minus_token,
              operand: unary_operator_node(
                operator: minus_token,
                operand: number_node(integer_token(2))
              )
            )
          )
        end

        it { is_expected.to be_an_ast tree }
      end

      context 'with parentheses' do
        let(:input) { '5 - - - + - (3 + 4) - +2' }

        let(:tree) do
          binary_operator_node(
            left: binary_operator_node(
              left: number_node(integer_token(5)),
              operator: minus_token,
              right: unary_operator_node(
                operator: minus_token,
                operand: unary_operator_node(
                  operator: minus_token,
                  operand: unary_operator_node(
                    operator: plus_token,
                    operand: unary_operator_node(
                      operator: minus_token,
                      operand: binary_operator_node(
                        left: number_node(integer_token(3)),
                        operator: plus_token,
                        right: number_node(integer_token(4))
                      )
                    )
                  )
                )
              )
            ),
            operator: minus_token,
            right: unary_operator_node(
              operator: plus_token,
              operand: number_node(integer_token(2))
            )
          )
        end

        it { is_expected.to be_an_ast tree }
      end
    end

    context 'without parentheses' do
      let(:input) { '14 + 2 * 3 - 6 / 2' }

      let(:tree) do
        binary_operator_node(
          left: binary_operator_node(
            left: number_node(integer_token(14)),
            operator: plus_token,
            right: binary_operator_node(
              left: number_node(integer_token(2)),
              operator: multiply_token,
              right: number_node(integer_token(3))
            )
          ),
          operator: minus_token,
          right: binary_operator_node(
            left: number_node(integer_token(6)),
            operator: divide_token,
            right: number_node(integer_token(2))
          )
        )
      end

      it { is_expected.to be_an_ast tree }
    end

    context 'with parentheses' do
      let(:input) { '7 + 3 * (10 / (12 / (3 + 1) - 1))' }

      let(:tree) do
        binary_operator_node(
          left: number_node(integer_token(7)),
          operator: plus_token,
          right: binary_operator_node(
            left: number_node(integer_token(3)),
            operator: multiply_token,
            right: binary_operator_node(
              left: number_node(integer_token(10)),
              operator: divide_token,
              right: binary_operator_node(
                left: binary_operator_node(
                  left: number_node(integer_token(12)),
                  operator: divide_token,
                  right: binary_operator_node(
                    left: number_node(integer_token(3)),
                    operator: plus_token,
                    right: number_node(integer_token(1))
                  )
                ),
                operator: minus_token,
                right: number_node(integer_token(1))
              )
            )
          )
        )
      end

      it { is_expected.to be_an_ast tree }
    end
  end
end
