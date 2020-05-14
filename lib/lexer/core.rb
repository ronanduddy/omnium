# frozen_string_literal: true

# frozen_text_literal: true

module Lexer
  # The lexer returns tokens for a given text.
  class Core
    include Common
    include TokenHelper

    WHITESPACE = ' '

    INTEGER = /[0-9]/.freeze
    ALPHA = /[a-zA-Z]/.freeze
    IDENTIFIER = /[a-zA-Z0-9_]/.freeze

    class LexerError < StandardError; end

    def initialize(text)
      @text = text
      @pointer = 0
    end

    def next_token
      return new_eof_token if eos?

      advance while whitespace?

      (@pointer...@text.length).each do
        return tokenise
      end
    end

    private

    def eos?
      @pointer > @text.length - 1
    end

    def advance(n = 1)
      @pointer += n
    end

    def character
      @character = @text[@pointer]
    end

    def peek
      return nil if eos?

      @text[@pointer + 1]
    end

    def whitespace?
      WHITESPACE == character
    end

    def integer
      result = ''

      while character =~ INTEGER
        result += character
        advance
      end

      result.to_i
    end

    def reserved_keyword
      result = ''

      while character =~ IDENTIFIER
        result += character
        advance
      end

      result
    end

    def assignment?
      colon = assignment_token(:value)[0]
      equals = assignment_token(:value)[1]

      character == colon && peek == equals
    end

    def tokenise
      if character =~ ALPHA
        word = reserved_keyword

        if RESERVED_KEYWORDS.include?(word.intern)
          send("new_#{word}_token")
        else
          new_identifier_token(word)
        end
      elsif character =~ INTEGER
        new_integer_token(integer)
      elsif plus?
        advance
        new_plus_token
      elsif minus?
        advance
        new_minus_token
      elsif multiply?
        advance
        new_multiply_token
      elsif divide?
        advance
        new_divide_token
      elsif left_parenthesis?
        advance
        new_left_parenthesis_token
      elsif right_parenthesis?
        advance
        new_right_parenthesis_token
      elsif assignment?
        advance(2)
        new_assignment_token
      elsif semicolon?
        advance
        new_semicolon_token
      elsif dot?
        advance
        new_dot_token
      else
        raise(LexerError, "Error tokenising #{character}")
      end
    end
  end
end
