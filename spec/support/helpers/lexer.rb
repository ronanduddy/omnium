# frozen_string_literal: true

require 'interpreter/lexer'

module Helpers
  module Lexer
    def mocked_lexer
      instance_double(Interpreter::Lexer)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Lexer
end
