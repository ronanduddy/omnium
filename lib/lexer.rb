# frozen_string_literal: true

# frozen_text_literal: true

# The lexer returns tokens for a given text.
class Lexer
  require_relative 'token'

  WHITESPACE = ' '
  PLUS = '+'
  MINUS = '-'
  MULTIPLY = '*'
  DIVIDE = '/'
  INTEGER = /[0-9]/.freeze
  LEFT_PARENTHESIS = '('
  RIGHT_PARENTHESIS = ')'

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

  def advance
    @pointer += 1
  end

  def character
    @text[@pointer]
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

  def token(type, value)
    Token.new(type, value)
  end

  def tokenise
    case character
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
    else
      raise(LexerError, "Error tokenising #{character}")
    end
  end
end
