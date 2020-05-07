# frozen_string_literal: true

require_relative 'ast'

# Binary operator represents the four binary operations: add, subtract, multiply
# and divide. @left and @right are the nodes representing operands (i.e. Number).
# @operator represents the operator as a token.
class BinaryOperator < AST
  attr_reader :left, :operator, :right

  def initialize(left, operator, right)
    @left = left
    @operator = operator
    @right = right
  end
end
