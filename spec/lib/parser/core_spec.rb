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

    context 'program definition' do
      let(:input) do
        'begin ' \
            'begin ' \
                'number := 2; ' \
                'a := number; ' \
                'b := 10 * a + 10 * number / 4; ' \
                'c := a - - b ' \
            'end; ' \
            'x := 11; ' \
        'end.'
      end

      let(:tree) do
        compound_node(
          [
            compound_node(
              [
                assignment_node(
                  left: variable_node(identifier_token('number')),
                  operator: assignment_token,
                  right: number_node(integer_token(2))
                ),
                assignment_node(
                  left: variable_node(identifier_token('a')),
                  operator: assignment_token,
                  right: variable_node(identifier_token('number'))
                ),
                assignment_node(
                  left: variable_node(identifier_token('b')),
                  operator: assignment_token,
                  right: binary_operator_node(
                    left: binary_operator_node(
                      left: number_node(integer_token(10)),
                      operator: multiply_token,
                      right: variable_node(identifier_token('a'))
                    ),
                    operator: plus_token,
                    right: binary_operator_node(
                      left: binary_operator_node(
                        left: number_node(integer_token(10)),
                        operator: multiply_token,
                        right: variable_node(identifier_token('number'))
                      ),
                      operator: divide_token,
                      right: number_node(integer_token(4))
                    )
                  )
                ),
                assignment_node(
                  left: variable_node(identifier_token('c')),
                  operator: assignment_token,
                  right: binary_operator_node(
                    left: variable_node(identifier_token('a')),
                    operator: minus_token,
                    right: unary_operator_node(
                      operand: variable_node(identifier_token('b')),
                      operator: minus_token
                    )
                  )
                )
              ]
            ),
            assignment_node(
              left: variable_node(identifier_token('x')),
              operator: assignment_token,
              right: number_node(integer_token(11))
            ),
            noop_node
          ]
        )
      end

      it { is_expected.to be_an_ast tree }
    end

    context 'arithmetic' do
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

    context 'with an invalid token' do
      subject(:parser) { described_class.new(lexer) }

      let(:lexer) do
        instance_double(Lexer::Core, next_token: token(:invalid, 'token'))
      end

      it 'raises an error with the following message' do
        # this example is coupled up to the implementation of the error handler
        expect { parse }.to raise_error(
          described_class::ParseError,
          "Expecting token type(s) 'plus, minus, integer, left_parenthesis, " \
          "right_parenthesis, identifier', got 'invalid'."
        )
      end
    end
  end
end
