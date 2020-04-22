# frozen_string_literal: true

module Interpreter
  # Expressions are resolved here from a list of terms.
  class Expression
    require_relative 'operators'
    include Operators

    class OperatorError < StandardError; end

    def initialize(terms)
      @terms = terms
      @value = nil
      @peeked_value = nil
    end

    def evaluate
      @value = @terms.first

      @terms.each_with_index do |term, index|
        next unless index.odd?

        peek(index)
        break if @peeked_value.nil?

        calculate(term)
      end

      @value
    end

    private

    def peek(index)
      @peeked_value = @terms[index + 1]
    end

    def calculate(term)
      case term
      when OPERATORS[:plus]
        add
      when OPERATORS[:minus]
        subtract
      when OPERATORS[:multiply]
        multipy
      when OPERATORS[:divide]
        divide
      else
        error("Unsupported operator: #{term}")
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
