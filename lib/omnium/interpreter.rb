# frozen_string_literal: true

module Omnium
  module Interpreter
    require 'omnium/interpreter/node_visitor'
    require 'omnium/interpreter/core'

    def self.new(parser)
      Interpreter::Core.new(parser)
    end
  end
end
