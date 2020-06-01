# frozen_string_literal: true

require 'pluck/lexer/token'

module Helpers
  module TokenHelper
    def token(type, value)
      Pluck::Lexer::Token.new(type, value)
    end

    def integer_token(value)
      Pluck::Lexer::Token.new(:integer, value)
    end

    def real_token(value)
      Pluck::Lexer::Token.new(:real, value)
    end

    def plus_token
      Pluck::Lexer::Token.new(:plus, '+')
    end

    def minus_token
      Pluck::Lexer::Token.new(:minus, '-')
    end

    def multiply_token
      Pluck::Lexer::Token.new(:multiply, '*')
    end

    def divide_token
      Pluck::Lexer::Token.new(:divide, '/')
    end

    def left_parenthesis_token
      Pluck::Lexer::Token.new(:left_parenthesis, '(')
    end

    def right_parenthesis_token
      Pluck::Lexer::Token.new(:right_parenthesis, ')')
    end

    def semicolon_token
      Pluck::Lexer::Token.new(:semicolon, ';')
    end

    def dot_token
      Pluck::Lexer::Token.new(:dot, '.')
    end

    def assignment_token
      Pluck::Lexer::Token.new(:assignment, ':=')
    end

    def identifier_token(name)
      Pluck::Lexer::Token.new(:identifier, name)
    end

    def begin_token
      Pluck::Lexer::Token.new(:begin, 'begin')
    end

    def end_token
      Pluck::Lexer::Token.new(:end, 'end')
    end

    def eof_token
      Pluck::Lexer::Token.new(:eof, nil)
    end

    def int_token
      Pluck::Lexer::Token.new(:int, 'int')
    end

    def float_token
      Pluck::Lexer::Token.new(:float, 'float')
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::TokenHelper
end
