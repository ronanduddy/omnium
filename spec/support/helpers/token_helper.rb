# frozen_string_literal: true

require 'lexer/token'

module Helpers
  module TokenHelper
    def token(type, value)
      Lexer::Token.new(type, value)
    end

    def integer_token(value)
      Lexer::Token.new(:integer, value)
    end

    def real_token(value)
      Lexer::Token.new(:real, value)
    end

    def plus_token
      Lexer::Token.new(:plus, '+')
    end

    def minus_token
      Lexer::Token.new(:minus, '-')
    end

    def multiply_token
      Lexer::Token.new(:multiply, '*')
    end

    def divide_token
      Lexer::Token.new(:divide, '/')
    end

    def left_parenthesis_token
      Lexer::Token.new(:left_parenthesis, '(')
    end

    def right_parenthesis_token
      Lexer::Token.new(:right_parenthesis, ')')
    end

    def semicolon_token
      Lexer::Token.new(:semicolon, ';')
    end

    def dot_token
      Lexer::Token.new(:dot, '.')
    end

    def assignment_token
      Lexer::Token.new(:assignment, ':=')
    end

    def identifier_token(name)
      Lexer::Token.new(:identifier, name)
    end

    def begin_token
      Lexer::Token.new(:begin, 'begin')
    end

    def end_token
      Lexer::Token.new(:end, 'end')
    end

    def eof_token
      Lexer::Token.new(:eof, nil)
    end

    def int_token
      Lexer::Token.new(:int, 'int')
    end

    def float_token
      Lexer::Token.new(:float, 'float')
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::TokenHelper
end
