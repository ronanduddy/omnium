# frozen_string_literal: true

module Interpreter
  # The parser will verify the format of a list of tokens (syntax analysis).
  class Parser
    require_relative 'expression'

    PLUS = :plus
    MINUS = :minus
    MULTIPLY = :multiply
    DIVIDE = :divide
    INTEGER = :integer
    EOF = :eof
    PLUS_OR_MINUS = :plus_or_minus
    MULTIPLY_OR_DIVIDE = :multiply_or_divide

    class ParserError < StandardError; end

    def initialize(lexer)
      @lexer = lexer
      @token = nil
    end

    def parse
      arithmetic
    end

    private

    def arithmetic
      @token = @lexer.next_token
      plus_minus
    end

    def plus_minus
      # plus_minus : multiply_divide ((PLUS | MINUS) multiply_divide)*
      result = multiply_divide

      while plus_or_minus?
        operator = @token
        consume(PLUS_OR_MINUS)
        result = expression(result, operator.value, multiply_divide)
      end

      result
    end

    def multiply_divide
      # multiply_divide : number ((MULTIPLY | DIVIDE) number)*
      result = number

      while multiply_or_divide?
        operator = @token
        consume(MULTIPLY_OR_DIVIDE)
        result = expression(result, operator.value, number)
      end

      result
    end

    def number
      # number : INTEGER
      token = @token
      consume(INTEGER)

      token.value
    end

    def consume(type)
      # verify the type of @token and advance @token to next_token
      verify(type)
      @token = @lexer.next_token
    end

    def expression(left, operator, right)
      Interpreter::Expression.new(
        { left: left, operator: operator, right: right }
      ).evaluate
    end

    def verify(type)
      # could thise exist in a verifier/type checker class?
      case type
      when PLUS_OR_MINUS
        return if plus_or_minus?
      when MULTIPLY_OR_DIVIDE
        return if multiply_or_divide?
      when INTEGER
        return if integer?
      when EOF
        return if @token.eof?
      end

      error("Invalid token: #{@token.inspect}")
    end

    def plus_or_minus?
      @token.type == PLUS || @token.type == MINUS
    end

    def multiply_or_divide?
      @token.type == MULTIPLY || @token.type == DIVIDE
    end

    def integer?
      @token.type == INTEGER
    end

    def error(message)
      raise(ParserError, message)
    end
  end
end
