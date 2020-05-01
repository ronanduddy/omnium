# frozen_string_literal: true

# The parser will verify the format of a list of tokens (syntax analysis) by
# 'recursive-descent'.
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
    # multiply_divide : number_parentheses ((MULTIPLY | DIVIDE) number_parentheses)*
    result = number_parentheses

    while @token.type == MULTIPLY || @token.type == DIVIDE
      if @token.type == MULTIPLY
        consume(MULTIPLY)
        result *= number_parentheses
      elsif @token.type == DIVIDE
        consume(DIVIDE)
        result /= number_parentheses
      end
    end

    result
  end

  def number_parentheses
    # number_parentheses : INTEGER | LEFT_PARENTHESIS plus_minus RIGHT_PARENTHESIS
    result = 0

    if @token.type == INTEGER
      consume(INTEGER)
      result = @token.value
    elsif
      consume(LEFT_PARENTHESIS)
      result = plus_minus
      consume(RIGHT_PARENTHESIS)
    end

    result
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
    when LEFT_PARENTHESIS
      return if @token.type == LEFT_PARENTHESIS
    when RIGHT_PARENTHESIS
      return if @token.type == RIGHT_PARENTHESIS
    when EOF
      return if @token.eof?
    else
      raise(ParserError, "Invalid token: #{@token.inspect}")
    end
  end
end
