# frozen_string_literal: true

module Interpreter
  # A single place to represent operators and some sharable behaviour.
  module Operators
    PLUS = '+'
    MINUS = '-'
    MULTIPLY = '*'
    DIVIDE = '/'

    OPERATORS = {
      plus: PLUS,
      minus: MINUS,
      multiply: MULTIPLY,
      divide: DIVIDE
    }.freeze

    def plus?(character)
      character == PLUS
    end

    def minus?(character)
      character == MINUS
    end

    def multiply?(character)
      character == MULTIPLY
    end

    def divide?(character)
      character == DIVIDE
    end

    def operator?(character)
      OPERATORS.values.include?(character)
    end
  end
end
