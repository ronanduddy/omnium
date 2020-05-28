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
        'program test;' \
        'var ' \
          'a, b : int;' \
          'y    : float;' \
        "begin # comment here\n" \
          'a := 2;' \
          'b := 10 * a + 10 * a / 4;' \
          'y := 20 / 7 + 3.14;' \
        'end.'
      end

      let(:tree) do
        program_node(
          name: "test",
          block: block_node(
            variable_declarations: [
              [
                variable_declaration_node(
                  data_type: data_type_node(int_token),
                  identifier: identifier_node(identifier_token('a'))
                ),
                variable_declaration_node(
                  data_type: data_type_node(int_token),
                  identifier: identifier_node(identifier_token('b'))
                )
              ],
              [
                variable_declaration_node(
                  data_type: data_type_node(float_token),
                  identifier: identifier_node(identifier_token('y'))
                )
              ]
            ],
            compound_statements: compound_node(
              [
                assignment_node(
                  left: identifier_node(identifier_token('a')),
                  operator: assignment_token,
                  right: number_node(integer_token(2))
                ),
                assignment_node(
                  left: identifier_node(identifier_token('b')),
                  operator: assignment_token,
                  right: binary_operator_node(
                    left: binary_operator_node(
                      left: number_node(integer_token(10)),
                      operator: multiply_token,
                      right: identifier_node(identifier_token('a'))
                    ),
                    operator: plus_token,
                    right: binary_operator_node(
                      left: binary_operator_node(
                        left: number_node(integer_token(10)),
                        operator: multiply_token,
                        right: identifier_node(identifier_token('a'))
                      ),
                      operator: divide_token,
                      right: number_node(integer_token(4))
                    )
                  )
                ),
                assignment_node(
                  left: identifier_node(identifier_token('y')),
                  operator: assignment_token,
                  right: binary_operator_node(
                    left: binary_operator_node(
                      left: number_node(integer_token(20)),
                      operator: divide_token,
                      right: number_node(integer_token(7))
                    ),
                    operator: plus_token,
                    right: number_node(real_token(3.14))
                  )
                ),
                noop_node
              ] # []
            ) # compound_node
          ) # block_node
        ) # program_node
      end

      it { is_expected.to be_an_ast tree }
    end

    context 'with an invalid token' do
      let(:input) { 'pancake' }

      it 'raises an error with the following message' do
        # this example is coupled up to the implementation of the error handler
        expect { parse }.to raise_error(
          described_class::ParseError,
          "Expecting token type(s) 'program', got 'identifier'."
        )
      end
    end
  end
end
