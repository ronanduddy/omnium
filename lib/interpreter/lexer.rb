# frozen_string_literal: true

module Interpreter
  # The lexer (also called a tokeniser or scanner) is used to pull apart a string
  # into its various tokens or terms; lexical analysis.
  class Lexer
    require_relative 'scanner'
    require_relative 'token'

    class LexerError < StandardError; end

    def initialize(string)
      @scanner = Scanner.new(string)
    end

    def next_token
      value = @scanner.scan

      return Token.new(:integer, value.to_i) if value =~ /[0-9]/
      return Token.new(:plus, value) if value == '+'
      return Token.new(:minus, value) if value == '-'
      return Token.new(:multiply, value) if value == '*'
      return Token.new(:divide, value) if value == '/'
      return Token.new(:eof, nil) if @scanner.eos?

      raise(LexerError, "Error tokenising #{value}")
    end
  end
end
