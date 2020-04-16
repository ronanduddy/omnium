# frozen_string_literal: true

module Interpreter
  module Operators
    OPERATORS = ['+', '-', '*', '/'].freeze

    def operator?(character)
      OPERATORS.include?(character)
    end
  end
end
