# frozen_string_literal: true

require 'unary_operator'

module Helpers
  module UnaryOperatorHelper
    def unary_operator_node(operator:, operand:)
      UnaryOperator.new(operator, operand)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::UnaryOperatorHelper
end
