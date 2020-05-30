# frozen_string_literal: true

module Lexer
  require './lib/lexer/token'
  require './lib/lexer/token_helper'
  require './lib/lexer/core'

  def self.new(input)
    Lexer::Core.new(input)
  end
end
