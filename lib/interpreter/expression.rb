# frozen_string_literal: true

module Interpreter
  class Expression
    class OperatorError < StandardError; end

    OPERATORS = {
      plus: '+',
      minus: '-',
      multipy: '*',
      divide: '/'
    }.freeze

    def initialize(left, operator, right)
      @left = left
      @operator = operator
      @right = right
    end

    def evaluate
      case @operator
      when OPERATORS[:plus]
        add
      when OPERATORS[:minus]
        subtract
      when OPERATORS[:multipy]
        multipy
      when OPERATORS[:divide]
        divide
      else
        error("Unsupported operator: #{@operator}")
      end
    end

    private

    def add
      @left + @right
    end

    def subtract
      @left - @right
    end

    def multipy
      @left * @right
    end

    def divide
      @left / @right
    end

    def error(message)
      raise(OperatorError, message)
    end
  end
end
