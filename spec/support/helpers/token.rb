# frozen_string_literal: true

require 'interpreter/token'

module Helpers
  module Token
    def mocked_token(type, value)
      instance_double(Interpreter::Token, type: type, value: value)
    end

    def mocked_integer_token(value)
      instance_double(Interpreter::Token, type: :integer, value: value)
    end

    def mocked_plus_token
      instance_double(Interpreter::Token, type: :minus, value: '+')
    end

    def mocked_minus_token
      instance_double(Interpreter::Token, type: :minus, value: '-')
    end

    def mocked_multiply_token
      instance_double(Interpreter::Token, type: :multiply, value: '*')
    end

    def mocked_divide_token
      instance_double(Interpreter::Token, type: :divide, value: '/')
    end

    def mocked_eof_token
      instance_double(Interpreter::Token, type: :eof, value: nil)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Token
end
