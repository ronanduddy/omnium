# frozen_string_literal: true

require 'parser/ast/base'
require 'parser/ast/unary_operator'
require 'support/helpers/token_helper'
require 'support/matchers/token'

RSpec.describe Parser::AST::UnaryOperator do
  subject(:unary_operator) { described_class.new(operator, operand) }

  let(:operator) { minus_token }
  let(:operand) { integer_token 5 }

  describe '#initialize' do
    it 'has the correct properties' do
      expect(unary_operator.operator).to be_a_minus_token
      expect(unary_operator.operand).to be_an_integer_token 5
    end
  end
end
