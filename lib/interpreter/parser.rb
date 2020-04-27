# frozen_string_literal: true

module Interpreter
  # The parser will verify the format of a list of tokens (syntax analysis).
  class Parser
    require_relative 'expression'

    INTEGER = :integer
    OPERATOR = :operator
    PLUS = :plus
    MINUS = :minus
    MULTIPLY = :multiply
    DIVIDE = :divide

    class ParserError < StandardError; end

    def initialize(lexer)
      @lexer = lexer
      @token = nil
    end

    def parse
      # parse : number ((PLUS|MINUS|MUL|DIV) number)*
      @token = @lexer.next_token
      value = number

      until @token.eof?
        operator = @token
        consume(OPERATOR)
        value = expression(value, operator.value, number)
      end

      value
    end

    private

    def consume(type)
      # verify the type of @token and advance @token to next_token
      verify(type)
      @token = @lexer.next_token
    end

    def number
      # number : INTEGER
      token = @token
      consume(INTEGER)

      token.value
    end

    def expression(left, operator, right)
      Interpreter::Expression.new(
        { left: left, operator: operator, right: right }
      ).evaluate
    end

    def verify(type)
      case type
      when :operator
        return if @token.type == :plus ||
                  @token.type == :minus ||
                  @token.type == :multiply ||
                  @token.type == :divide
      when :integer
        return if @token.type == :integer
      when :eof
        return if @token.type == :eof
      end

      error("Invalid token: #{@token.inspect}")
    end

    def error(message)
      raise(ParserError, message)
    end
  end
end
