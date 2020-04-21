# frozen_string_literal: true

module Interpreter
  # The parser will verify the format of a list of tokens (syntax analysis).
  class Parser
    class ParserError < StandardError; end

    def initialize(tokens)
      @tokens = tokens
    end

    def evaluate
      parts = []

      @tokens.each_with_index do |token, index|
        break if token.type == :eof # hacky...

        if index.even?
          verify(token, :integer)
        else
          verify(token, :operator)
        end

        parts << token.value
      end

      parts
    end

    private

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
