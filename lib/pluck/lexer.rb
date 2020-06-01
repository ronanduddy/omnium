# frozen_string_literal: true

module Pluck
  module Lexer
    require 'pluck/lexer/token'
    require 'pluck/lexer/token_helper'
    require 'pluck/lexer/core'

    def self.new(input)
      Lexer::Core.new(input)
    end
  end
end
