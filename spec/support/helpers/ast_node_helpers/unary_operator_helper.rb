# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module UnaryOperatorHelper
      def unary_operator_node(operator:, operand:)
        Parser::AST::UnaryOperator.new(operator, operand)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::UnaryOperatorHelper
end
