# frozen_string_literal: true

require 'parser/ast/unary_operator'

module Helpers
  module AstNodeHelpers
    module UnaryOperatorHelper
      include Parser::AST

      def unary_operator_node(operator:, operand:)
        UnaryOperator.new(operator, operand)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::UnaryOperatorHelper
end
