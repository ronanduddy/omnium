# frozen_string_literal: true

require 'support/helpers/token_helper'
require 'support/helpers/ast_node_helpers'

RSpec.describe Interpreter::Core do
  subject(:interpreter) { described_class.new(parser) }

  let(:parser) { instance_double(Omnium::Parser::Core, parse: tree) }
  let(:tree) do
    compound_node(
      [
        compound_node(
          [
            assignment_node(
              left: identifier_node(identifier_token('number')),
              operator: assignment_token,
              right: number_node(integer_token(2))
            ),
            assignment_node(
              left: identifier_node(identifier_token('a')),
              operator: assignment_token,
              right: identifier_node(identifier_token('number'))
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
                    right: identifier_node(identifier_token('number'))
                  ),
                  operator: divide_token,
                  right: number_node(integer_token(4))
                )
              )
            ),
            assignment_node(
              left: identifier_node(identifier_token('c')),
              operator: assignment_token,
              right: binary_operator_node(
                left: identifier_node(identifier_token('a')),
                operator: minus_token,
                right: unary_operator_node(
                  operand: identifier_node(identifier_token('b')),
                  operator: minus_token
                )
              )
            )
          ]
        ),
        assignment_node(
          left: identifier_node(identifier_token('x')),
          operator: assignment_token,
          right: number_node(integer_token(11))
        ),
        noop_node
      ]
    )
  end

  describe '#interpret' do
    subject(:interpret) { interpreter.interpret }

    it 'creates the correct symbol_table' do
      interpret
      expected = { a: 2, b: 25, c: 27, number: 2, x: 11 }
      expect(interpreter.symbol_table).to eq(expected)
    end
  end

  describe '#visit_Program' do
    subject(:visit_Program) { interpreter.visit_Program(node) }

    let(:node) do
      program_node(
        name: 'test',
        block: block_node(
          variable_declarations: [
            variable_declaration_node(
              data_type: data_type_node(int_token),
              identifier: identifier_node(identifier_token('a'))
            )
          ],
          compound_statement: compound_node(
            [
              assignment_node(
                left: identifier_node(identifier_token('a')),
                operator: assignment_token,
                right: number_node(integer_token(2))
              ),
              noop_node
            ] # []
          ) # compound_node
        ) # block_node
      ) # program_node
    end

    it 'creates the correct symbol_table' do
      visit_Program
      expect(interpreter.name).to eq('test')
      expect(interpreter.symbol_table).to eq({ a: 2 })
    end
  end

  describe '#visit_Block' do
    subject(:visit_Block) { interpreter.visit_Block(node) }

    let(:node) do
      block_node(
        variable_declarations: [
          variable_declaration_node(
            data_type: data_type_node(float_token),
            identifier: identifier_node(identifier_token('a'))
          )
        ],
        compound_statement: compound_node(
          [
            assignment_node(
              left: identifier_node(identifier_token('a')),
              operator: assignment_token,
              right: number_node(integer_token(2.12))
            ),
            noop_node
          ] # []
        ) # compound_node
      ) # block_node
    end

    it 'creates the correct symbol_table' do
      visit_Block
      expect(interpreter.symbol_table).to eq({ a: 2.12 })
    end
  end

  describe '#visit_Compound' do
    subject(:visit_Compound) { interpreter.visit_Compound(node) }

    let(:node) do
      compound_node(
        [
          assignment_node(
            left: identifier_node(identifier_token('number')),
            operator: assignment_token,
            right: number_node(integer_token(2))
          ),
          assignment_node(
            left: identifier_node(identifier_token('a')),
            operator: assignment_token,
            right: identifier_node(identifier_token('number'))
          )
        ]
      )
    end

    it 'creates the correct symbol_table' do
      visit_Compound
      expect(interpreter.symbol_table).to eq({ number: 2, a: 2 })
    end
  end

  describe '#visit_VariableDeclaration' do
    subject(:visit_VariableDeclaration) { interpreter.visit_VariableDeclaration(node) }

    let(:node) do
      variable_declaration_node(
        data_type: data_type_node(int_token),
        identifier: identifier_node(identifier_token('a'))
      )
    end

    it { is_expected.to be nil }
  end

  describe '#visit_Assignment' do
    subject(:visit_Assignment) { interpreter.visit_Assignment(node) }

    let(:node) do
      assignment_node(
        left: identifier_node(identifier_token('number')),
        operator: assignment_token,
        right: number_node(integer_token(2))
      )
    end

    it 'creates the correct symbol_table' do
      visit_Assignment
      expect(interpreter.symbol_table).to eq({ number: 2 })
    end
  end

  describe '#visit_Identifier' do
    subject(:visit_Identifier) { interpreter.visit_Identifier(node) }

    let(:node) do
      identifier_node(identifier_token('number'))
    end

    context 'when the variable does exist in the symbol_table' do
      before { allow(interpreter).to receive(:symbol_table) { { number: 3 } } }

      it { is_expected.to eq 3 }
    end

    context 'when the variable does not exist in the symbol_table' do
      it 'raises an error' do
        expect { visit_Identifier }.to raise_error(
          described_class::InterpreterError
        )
      end
    end
  end

  describe '#visit_DataType' do
    subject(:visit_DataType) { interpreter.visit_DataType(node) }

    let(:node) do
      data_type_node(int_token)
    end

    it { is_expected.to be nil }
  end

  describe '#visit_NoOperation' do
    subject(:visit_NoOperation) { interpreter.visit_NoOperation(node) }

    let(:node) { 'noop' }

    it { is_expected.to be nil }
  end

  describe '#visit_BinaryOperator' do
    subject(:visit_BinaryOperator) { interpreter.visit_BinaryOperator(node) }

    let(:node) do
      binary_operator_node(
        left: number_node(integer_token(9)),
        operator: operator,
        right: number_node(integer_token(3))
      )
    end

    context 'when addition' do
      let(:operator) { plus_token }

      it { is_expected.to eq 12 }
    end

    context 'when subtraction' do
      let(:operator) { minus_token }

      it { is_expected.to eq 6 }
    end

    context 'when multiplication' do
      let(:operator) { multiply_token }

      it { is_expected.to eq 27 }
    end

    context 'when division' do
      let(:operator) { divide_token }

      it { is_expected.to eq 3 }
    end
  end

  describe '#visit_UnaryOperator' do
    subject(:visit_UnaryOperator) { interpreter.visit_UnaryOperator(node) }

    # ---3 = -3
    let(:node) do
      unary_operator_node(
        operator: minus_token,
        operand: unary_operator_node(
          operator: minus_token,
          operand: unary_operator_node(
            operator: minus_token,
            operand: number_node(integer_token(3))
          )
        )
      )
    end

    it { is_expected.to eq(-3) }
  end

  describe '#visit_Number' do
    subject(:visit_Number) { interpreter.visit_Number(node) }

    let(:node) { number_node(integer_token(2)) }

    it { is_expected.to eq 2 }
  end
end
