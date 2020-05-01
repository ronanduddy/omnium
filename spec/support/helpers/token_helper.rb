# frozen_string_literal: true

require 'token'

module Helpers
  module TokenHelper
    def mocked_token(type, value)
      instance_double(Token, type: type, value: value)
    end

    def mocked_integer_token(value)
      instance_double(Token, type: :integer, value: value)
    end

    def mocked_plus_token
      instance_double(Token, type: :plus, value: '+')
    end

    def mocked_minus_token
      instance_double(Token, type: :minus, value: '-')
    end

    def mocked_multiply_token
      instance_double(Token, type: :multiply, value: '*')
    end

    def mocked_divide_token
      instance_double(Token, type: :divide, value: '/')
    end

    def mocked_left_parenthesis_token
      instance_double(Token, type: :left_parenthesis, value: '(')
    end

    def mocked_right_parenthesis_token
      instance_double(Token, type: :right_parenthesis, value: ')')
    end

    def mocked_eof_token
      instance_double(Token, type: :eof, value: nil)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::TokenHelper
end
