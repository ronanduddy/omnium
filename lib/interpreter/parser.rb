# frozen_string_literal: true

module Interpreter
  # The parser will verify the format of a list of tokens (syntax analysis).
  class Parser
    PLUS = :plus
    MINUS = :minus
    MULTIPLY = :multiply
    DIVIDE = :divide
    INTEGER = :integer
    LEFT_PARENTHESIS = :left_parenthesis
    RIGHT_PARENTHESIS = :right_parenthesis
    EOF = :eof

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

      while @token.type == PLUS || @token.type == MINUS
        if @token.type == PLUS
          consume(PLUS)
          result += multiply_divide
        elsif @token.type == MINUS
          consume(MINUS)
          result -= multiply_divide
        end
      end

      result
    end

    def multiply_divide
      # multiply_divide : number ((MULTIPLY | DIVIDE) number)*
      result = number

      while @token.type == MULTIPLY || @token.type == DIVIDE
        if @token.type == MULTIPLY
          consume(MULTIPLY)
          result *= number
        elsif @token.type == DIVIDE
          consume(DIVIDE)
          result /= number
        end
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

    def verify(type)
      case type
      when PLUS
        return if @token.type == PLUS
      when MINUS
        return if @token.type == MINUS
      when MULTIPLY
        return if @token.type == MULTIPLY
      when DIVIDE
        return if @token.type == DIVIDE
      when INTEGER
        return if @token.type == INTEGER
      when EOF
        return if @token.eof?
      else
        raise(ParserError, "Invalid token: #{@token.inspect}")
      end
    end
  end
end
