# frozen_string_literal: true

module Omnium
  module Lexer
    require 'omnium/lexer/token'
    require 'omnium/lexer/token_helper'
    require 'omnium/lexer/core'

    def self.new(input)
      Lexer::Core.new(input)
    end
  end
end
