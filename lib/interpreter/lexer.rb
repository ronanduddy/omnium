# frozen_string_literal: true

module Interpreter
  # The lexer (also called a tokeniser or scanner) is used to pull apart a string
  # into its various tokens or parts; lexical analysis.
  class Lexer
    require_relative 'scanner'
    require_relative 'token'
    require_relative 'expression'

    class LexerError < StandardError; end

    def initialize(string)
      @scanner = Scanner.new(string)
      @tokens = []
    end

    def evaluate
      tokenise

      # parse
      left = @tokens[0]
      verify(left, :integer)

      operator = @tokens[1]
      verify(operator, :operator)

      right = @tokens[2]
      verify(right, :integer)

      expression = Expression.new(left.value, operator.value, right.value)
      expression.evaluate
    end

    private

    def tokenise
      loop do
        string = @scanner.next_word || @scanner.next_operator
        @tokens << token(string)
        break if @scanner.eos?
      end
    end

    def token(string)
      # could create a 'caster' class for this stuff
      return Token.new(:integer, string.to_i) if string =~ /[0-9]/
      return Token.new(:plus, string) if string == '+'
      return Token.new(:minus, string) if string == '-'
      return Token.new(:eof, nil) if @scanner.eos?

      error("Error tokenising #{string}")
    end

    def verify(current_token, token_type)
      # I think this would belong in a 'parser'/verifier class

      case token_type
      when :operator
        return if current_token.type == :plus || current_token.type == :minus
      when :integer
        return if current_token.type == :integer
      when :eof
        return if current_token.type == :eof
      end

      error("Invalid token: #{current_token.str}")
    end

    def error(message)
      raise(LexerError, message)
    end
  end
end
