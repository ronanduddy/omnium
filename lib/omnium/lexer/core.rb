# frozen_string_literal: true

# frozen_text_literal: true

module Omnium
  module Lexer
    # The lexer returns tokens for a given text.
    class Core
      include Common
      include TokenHelper

      WHITESPACE = ' '
      COMMENT = '#'
      NEWLINE = "\n"
      DECIMAL_POINT = '.'

      INTEGER = /[0-9]/.freeze
      ALPHA = /[a-zA-Z]/.freeze
      IDENTIFIER = /[a-zA-Z0-9_]/.freeze

      class LexerError < StandardError; end

      def initialize(text)
        @text = text
        @pointer = 0
      end

      def next_token
        ignore
        return new_eof_token if eos?

        (@pointer...@text.length).each do
          return tokenise
        end
      end

      private

      def ignore
        advance while whitespace? || newline?

        if comment?
          advance until newline? # comment text
          ignore if whitespace? || newline? # skip any other junk
        end
      end

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
        character == WHITESPACE
      end

      def comment?
        character == COMMENT
      end

      def newline?
        character == NEWLINE
      end

      def decimal?
        character == DECIMAL_POINT
      end

      def number
        result = ''

        while character =~ INTEGER
          result += character
          advance
        end

        if decimal?
          result += character
          advance

          while character =~ INTEGER
            result += character
            advance
          end

          return result.to_f
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

      def word_token(word)
        if RESERVED_KEYWORDS.include?(word.intern)
          send("new_#{word}_token")
        else
          new_identifier_token(word)
        end
      end

      def number_token(num)
        return new_integer_token(num) if num.is_a? Integer

        new_real_token(num)
      end

      def tokenise
        if character =~ ALPHA
          word_token(reserved_keyword)
        elsif character =~ INTEGER
          number_token(number)
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
        elsif colon?
          advance
          new_colon_token
        elsif comma?
          advance
          new_comma_token
        elsif dot?
          advance
          new_dot_token
        else
          raise(LexerError, "Error tokenising '#{character}' at position #{@pointer}")
        end
      end
    end
  end
end
