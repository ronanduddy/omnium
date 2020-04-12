# frozen_string_literal: true

module Interpreter
  class Tokeniser
    require_relative 'token'
    class TokeniserError < StandardError; end

    attr_reader :text

    def initialize(text)
      @text = text
      @position = 0 # index for @text
      @current_token = nil
    end

    def expression
      @current_token = next_token

      left = @current_token
      verify(:integer)
      @current_token = next_token

      operator = @current_token
      verify(:plus)
      @current_token = next_token

      right = @current_token
      verify(:integer)
      @current_token = next_token

      left.value + right.value
    end

    private

    def next_token
      return Token.new(:eof, nil) if @position > text.length - 1

      character = text[@position]

      if character =~ /[0-9]/ && @position += 1
        return Token.new(:integer, character.to_i)
      end

      return Token.new(:plus, character) if character == '+' && @position += 1

      error("Error tokenising #{character}")
    end

    def verify(token_type)
      return if @current_token.type == token_type

      error("Invalid token type #{@current_token.type}")
    end

    def error(message)
      raise(TokeniserError, message)
    end
  end
end
