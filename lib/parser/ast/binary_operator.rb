# frozen_string_literal: true

module Parser
  module AST
    # Binary operator represents the four binary operations: add, subtract, multiply
    # and divide. @left and @right are the nodes representing operands (i.e. Number).
    # @operator represents the operator as a token.
    class BinaryOperator < Base
      attr_reader :left, :operator, :right

      def initialize(left, operator, right)
        @left = left
        @operator = operator
        @right = right
      end
    end
  end
end
