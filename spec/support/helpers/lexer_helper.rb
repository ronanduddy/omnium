# frozen_string_literal: true

require 'lexer'

module Helpers
  module LexerHelper
    def lexer(input)
      Lexer.new(input)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::LexerHelper
end
