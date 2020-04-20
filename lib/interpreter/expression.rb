# frozen_string_literal: true

module Interpreter
  # Expressions are resolved here from a list of parts.
  class Expression
    require_relative 'operators'
    include Operators

    class OperatorError < StandardError; end

    def initialize(parts)
      @parts = parts
      @value = nil
      @peeked_value = nil
    end

    def evaluate
      @value = @parts.first

      @parts.each_with_index do |part, index|
        next unless index.odd?

        peek(index)
        break if @peeked_value.nil?

        calculate(part)
      end

      @value
    end

    private

    def peek(index)
      @peeked_value = @parts[index + 1]
    end

    def calculate(part)
      case part
      when OPERATORS[:plus]
        add
      when OPERATORS[:minus]
        subtract
      when OPERATORS[:multiply]
        multipy
      when OPERATORS[:divide]
        divide
      else
        error("Unsupported operator: #{part}")
      end
    end

    def add
      @value += @peeked_value
    end

    def subtract
      @value -= @peeked_value
    end

    def multipy
      @value *= @peeked_value
    end

    def divide
      @value /= @peeked_value
    end

    def error(message)
      raise(OperatorError, message)
    end
  end
end
