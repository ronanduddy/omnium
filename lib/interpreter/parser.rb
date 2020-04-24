# frozen_string_literal: true

module Interpreter
  # The parser will verify the format of a list of tokens (syntax analysis).
  class Parser
    require_relative 'expression'

    class ParserError < StandardError; end

    def initialize(tokens)
      @tokens = tokens
      @current_token = nil
    end

    def parse
      value = nil

      @tokens.each_with_index do |token, index|
        break if token.type == :eof # hacky...

        if index.even?
          verify(token, :integer)
          next unless value.nil?

          value = token.value
        else
          verify(token, :operator)
          peeked_token = @tokens[index + 1]
          value = expression(value, token.value, peeked_token.value)
        end
      end

      value
    end

    private

    def expression(left, operator, right)
      Interpreter::Expression.new(
        { left: left, operator: operator, right: right }
      ).evaluate
    end

    def verify(token, type)
      case type
      when :operator
        return if token.type == :plus ||
                  token.type == :minus ||
                  token.type == :multiply ||
                  token.type == :divide
      when :integer
        return if token.type == :integer
      when :eof
        return if token.type == :eof
      end

      error("Invalid token: #{token.str}")
    end

    def error(message)
      raise(ParserError, message)
    end
  end
end
