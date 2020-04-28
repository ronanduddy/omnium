# frozen_string_literal: true

module Interpreter
  # Expressions are resolved here from a list of terms.
  class Expression
    require_relative 'operators'
    include Operators

    class OperatorError < StandardError; end

    def initialize(args)
      # should think about defaults for these fetches.
      @left = args.fetch(:left)
      @operator = args.fetch(:operator)
      @right = args.fetch(:right)
    end

    def evaluate
      case @operator
      when SYMBOLS[:plus]
        add
      when SYMBOLS[:minus]
        subtract
      when SYMBOLS[:multiply]
        multipy
      when SYMBOLS[:divide]
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
