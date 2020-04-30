# frozen_string_literal: true

module Interpreter
  # The lexer returns tokens for a given string.
  class Lexer
    require_relative 'token'

    WHITESPACE = ' '
    PLUS = '+'
    MINUS = '-'
    MULTIPLY = '*'
    DIVIDE = '/'
    LEFT_PARENTHESIS = '('
    RIGHT_PARENTHESIS = ')'

    class LexerError < StandardError; end

    def initialize(string)
      @string = string
      @pointer = 0
    end

    def next_token
      value = scan

      return Token.new(:integer, value.to_i) if value =~ /[0-9]/
      return Token.new(:plus, value) if value == PLUS
      return Token.new(:minus, value) if value == MINUS
      return Token.new(:multiply, value) if value == MULTIPLY
      return Token.new(:divide, value) if value == DIVIDE
      return Token.new(:left_parenthesis, value) if value == LEFT_PARENTHESIS
      return Token.new(:right_parenthesis, value) if value == RIGHT_PARENTHESIS
      return Token.new(:eof, nil) if eos?

      raise(LexerError, "Error tokenising #{value}")
    end

    private

    def eos?
      @pointer > @string.length - 1
    end

    def scan
      return nil if eos?

      advance while whitespace?

      term = ''
      (@pointer...@string.length).each do
        break if whitespace?

        term += consume
      end

      term
    end

    def consume
      char = character
      advance
      char
    end

    def advance
      @pointer += 1
    end

    def character
      @string[@pointer]
    end

    def whitespace?
      WHITESPACE == character
    end
  end
end
