# frozen_string_literal: true

require 'binary_operator'

module Helpers
  module BinaryOperatorHelper
    def binary_operator_node(left:, operator:, right:)
      BinaryOperator.new(left, operator, right)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::BinaryOperatorHelper
end
