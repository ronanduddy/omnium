# frozen_string_literal: true

module Pluck
  module Interpreter
    require 'pluck/interpreter/node_visitor'
    require 'pluck/interpreter/core'

    def self.new(parser)
      Interpreter::Core.new(parser)
    end
  end
end
