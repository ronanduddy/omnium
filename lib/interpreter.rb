# frozen_string_literal: true

module Interpreter
  require './lib/interpreter/node_visitor'
  require './lib/interpreter/core'

  def self.new(parser)
    Interpreter::Core.new(parser)
  end
end
