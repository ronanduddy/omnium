# frozen_string_literal: true

require 'token'

module Helpers
  module TokenHelper
    def token(type, value)
      Token.new(type, value)
    end

    def integer_token(value)
      Token.new(:integer, value)
    end

    def plus_token
      Token.new(:plus, '+')
    end

    def minus_token
      Token.new(:minus, '-')
    end

    def multiply_token
      Token.new(:multiply, '*')
    end

    def divide_token
      Token.new(:divide, '/')
    end

    def left_parenthesis_token
      Token.new(:left_parenthesis, '(')
    end

    def right_parenthesis_token
      Token.new(:right_parenthesis, ')')
    end

    def semicolon_token
      Token.new(:semicolon, ';')
    end

    def dot_token
      Token.new(:dot, '.')
    end

    def assignment_token
      Token.new(:assignment, ':=')
    end

    def identifier_token(name)
      Token.new(:id, name)
    end

    def begin_keyword_token
      Token.new(:begin, 'begin')
    end

    def end_keyword_token
      Token.new(:end, 'end')
    end

    def eof_token
      Token.new(:eof, nil)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::TokenHelper
end
