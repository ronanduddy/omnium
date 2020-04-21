# frozen_string_literal: true

module Interpreter
  # The lexer (also called a tokeniser or scanner) is used to pull apart a string
  # into its various tokens or parts; lexical analysis.
  class Lexer
    require_relative 'scanner'
    require_relative 'token'
    require_relative 'operators'
    include Operators

    class LexerError < StandardError; end

    def initialize(string)
      @scanner = Scanner.new(string)
    end

    def tokens
      @tokens ||= tokenise
    end

    private

    def tokenise
      tokens = []

      loop do
        string = @scanner.next_word || @scanner.next_operator
        tokens << token(string)
        break if string.nil? # this should be thought out better
      end

      tokens
    end

    def token(string)
      # could create a 'caster'/'typer' class for this stuff
      return Token.new(:integer, string.to_i) if string =~ /[0-9]/
      return Token.new(:plus, string) if plus?(string)
      return Token.new(:minus, string) if minus?(string)
      return Token.new(:multiply, string) if multiply?(string)
      return Token.new(:divide, string) if divide?(string)
      return Token.new(:eof, nil) if @scanner.eos?

      error("Error tokenising #{string}")
    end

    def error(message)
      raise(LexerError, message)
    end
  end
end
