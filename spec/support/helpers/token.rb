# frozen_string_literal: true

require 'interpreter/token'

module Helpers
  module Token
    def new_token(type, value)
      Interpreter::Token.new(type, value)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Token
end
