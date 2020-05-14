# frozen_string_literal: true

module Interpreter
  require 'interpreter/node_visitor'
  require 'interpreter/core'

  def self.new(parser)
    Interpreter::Core.new(parser)
  end
end
