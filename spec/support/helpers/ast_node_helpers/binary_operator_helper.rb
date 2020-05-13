# frozen_string_literal: true

require 'parser/ast/binary_operator'

module Helpers
  module AstNodeHelpers
    module BinaryOperatorHelper
      include Parser::AST

      def binary_operator_node(left:, operator:, right:)
        BinaryOperator.new(left, operator, right)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::BinaryOperatorHelper
end
