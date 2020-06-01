# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module BinaryOperatorHelper
      def binary_operator_node(left:, operator:, right:)
        Parser::AST::BinaryOperator.new(left, operator, right)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::BinaryOperatorHelper
end
