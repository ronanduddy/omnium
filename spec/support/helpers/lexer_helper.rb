# frozen_string_literal: true

module Helpers
  module LexerHelper
    def lexer(input)
      Lexer::Core.new(input)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::LexerHelper
end
