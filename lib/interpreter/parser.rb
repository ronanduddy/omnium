# frozen_string_literal: true

module Interpreter
  class Parser
    class ParserError < StandardError; end

    def initialize(tokens)
      @tokens = tokens
    end

    def evaluate
      left = @tokens[0]
      verify(left, :integer)

      operator = @tokens[1]
      verify(operator, :operator)

      right = @tokens[2]
      verify(right, :integer)

      { left: left.value, operator: operator.value, right: right.value }
    end

    private

    def verify(current_token, token_type)
      case token_type
      when :operator
        return if current_token.type == :plus ||
                  current_token.type == :minus ||
                  current_token.type == :multiply ||
                  current_token.type == :divide
      when :integer
        return if current_token.type == :integer
      when :eof
        return if current_token.type == :eof
      end

      error("Invalid token: #{current_token.str}")
    end

    def error(message)
      raise(ParserError, message)
    end
  end
end
