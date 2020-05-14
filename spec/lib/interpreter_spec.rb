# frozen_string_literal: true

require 'common'
require 'parser'
require 'interpreter'
require 'support/helpers/token_helper'
require 'support/helpers/ast_node_helpers'

RSpec.describe Interpreter do
  subject(:interpreter) { described_class.new(parser) }

  let(:parser) { instance_double(Parser::Core, parse: tree) }
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

  describe '#interpret' do
    subject(:interpret) { interpreter.interpret }

    it { is_expected.to eq 17 }
  end

  describe '#visit_Number' do
    subject(:visit_Number) { interpreter.visit_Number(node) }

    let(:node) { number_node(integer_token(2)) }

    it { is_expected.to eq 2 }
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
end
