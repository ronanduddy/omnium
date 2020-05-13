# frozen_string_literal: true

require 'parser/ast/unary_operator'
require 'support/helpers/token_helper'

RSpec.describe Parser::AST::UnaryOperator do
  subject(:unary_operator) { described_class.new(operator, operand) }

  let(:operator) { minus_token }
  let(:operand) { integer_token(5) }

  describe '#initialize' do
    #  a limp sort of test... 
    it { is_expected.to have_attributes(operator: operator, operand: operand) }
  end
end
