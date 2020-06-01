# frozen_string_literal: true

require 'pluck/lexer/core'

module Helpers
  module LexerHelper
    def lexer(input)
      Pluck::Lexer::Core.new(input)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::LexerHelper
end
