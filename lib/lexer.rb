# frozen_string_literal: true

module Lexer
  require 'lexer/token'
  require 'lexer/token_helper'
  require 'lexer/core'

  def self.new(input)
    Lexer::Core.new(input)
  end
end
