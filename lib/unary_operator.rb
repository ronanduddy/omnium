# frozen_string_literal: true

require_relative 'ast'

# Unary Operator represents a plus or minus on a number e.g. +1 or -5. That is
# an operator operating on one operand. @operator represents the unary operator
# token (plus or minus) and @operand represents another node (number or expression).
class UnaryOperator < AST
  attr_reader :operator, :operand

  def initialize(operator, operand)
    @operator = operator
    @operand = operand
  end
end