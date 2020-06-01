# frozen_string_literal: true

require 'pluck/parser/ast/unary_operator'

module Helpers
  module AstNodeHelpers
    module UnaryOperatorHelper
      def unary_operator_node(operator:, operand:)
        Pluck::Parser::AST::UnaryOperator.new(operator, operand)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::UnaryOperatorHelper
end
