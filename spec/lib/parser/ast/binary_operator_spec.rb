# frozen_string_literal: true

require 'parser/ast/base'
require 'parser/ast/binary_operator'
require 'support/helpers/token_helper'
require 'support/matchers/token'

RSpec.describe Parser::AST::BinaryOperator do
  subject(:binary_operator) { described_class.new(left, operator, right) }

  let(:left) { integer_token 2 }
  let(:operator) { plus_token }
  let(:right) { integer_token 5 }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(binary_operator.left).to be_an_integer_token 2
      expect(binary_operator.operator).to be_a_plus_token
      expect(binary_operator.right).to be_an_integer_token 5
    end
  end
end
