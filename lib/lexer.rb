# frozen_string_literal: true

# frozen_text_literal: true

require_relative 'token'

# The lexer returns tokens for a given text.
class Lexer
  WHITESPACE = ' '
  PLUS = '+'
  MINUS = '-'
  MULTIPLY = '*'
  DIVIDE = '/'
  LEFT_PARENTHESIS = '('
  RIGHT_PARENTHESIS = ')'
  SEMICOLON = ';'
  DOT = '.'
  ASSIGNMENT = [':', '='].freeze

  RESERVED_KEYWORDS = {
    begin: 'begin',
    end: 'end'
  }.freeze

  INTEGER = /[0-9]/.freeze
  ALPHA = /[a-zA-Z]/.freeze
  IDENTIFIER = /[a-zA-Z0-9_]/.freeze

  class LexerError < StandardError; end

  def initialize(text)
    @text = text
    @pointer = 0
  end

  def next_token
    return token(:eof, nil) if eos?

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
    @text[@pointer]
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
    proc { character == ASSIGNMENT.first && peek == ASSIGNMENT.last }
  end

  def token(type, value)
    Token.new(type, value)
  end

  def tokenise
    case character
    when ALPHA
      keyword = reserved_keyword

      if RESERVED_KEYWORDS.include?(keyword.intern)
        token(keyword.intern, keyword) # reserved keyword
      else
        token(:id, keyword) # variable/identifier
      end
    when INTEGER
      token(:integer, integer)
    when PLUS
      advance
      token(:plus, PLUS)
    when MINUS
      advance
      token(:minus, MINUS)
    when MULTIPLY
      advance
      token(:multiply, MULTIPLY)
    when DIVIDE
      advance
      token(:divide, DIVIDE)
    when LEFT_PARENTHESIS
      advance
      token(:left_parenthesis, LEFT_PARENTHESIS)
    when RIGHT_PARENTHESIS
      advance
      token(:right_parenthesis, RIGHT_PARENTHESIS)
    when assignment?
      advance(2)
      token(:assignment, ASSIGNMENT.join)
    when SEMICOLON
      advance
      token(:semicolon, SEMICOLON)
    when DOT
      advance
      token(:dot, DOT)
    else
      raise(LexerError, "Error tokenising #{character}")
    end
  end
end
