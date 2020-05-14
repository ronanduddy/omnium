# frozen_string_literal: true

# frozen_text_literal: true

require_relative 'token'
require_relative 'common'

# The lexer returns tokens for a given text.
class Lexer
  include Common

  INTEGER = /[0-9]/.freeze
  ALPHA = /[a-zA-Z]/.freeze
  IDENTIFIER = /[a-zA-Z0-9_]/.freeze

  class LexerError < StandardError; end

  def initialize(text)
    @text = text
    @pointer = 0
  end

  def next_token
    return eof_token if eos?

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
    colon = TOKENS[:assignment][:value][0]
    equals = TOKENS[:assignment][:value][1]

    character == colon && peek == equals
  end

  def tokenise
    if character =~ ALPHA
      word = reserved_keyword

      if RESERVED_KEYWORDS.include?(word.intern)
        send("#{word}_token")
      else
        identifier_token(word)
      end
    elsif character =~ INTEGER
      integer_token(integer)
    elsif plus?
      advance
      plus_token
    elsif minus?
      advance
      minus_token
    elsif multiply?
      advance
      multiply_token
    elsif divide?
      advance
      divide_token
    elsif left_parenthesis?
      advance
      left_parenthesis_token
    elsif right_parenthesis?
      advance
      right_parenthesis_token
    elsif assignment?
      advance(2)
      assignment_token
    elsif semicolon?
      advance
      semicolon_token
    elsif dot?
      advance
      dot_token
    else
      raise(LexerError, "Error tokenising #{character}")
    end
  end
end
