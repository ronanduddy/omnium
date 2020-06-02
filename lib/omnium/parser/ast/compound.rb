# frozen_string_literal: true

module Omnium
  module Parser
    module AST
      # This compound statement is for a 'begin ... end' block and therefore
      # represents a list of statement nodes as @children.
      class Compound < Base
        attr_reader :children

        def initialize
          @children = []
        end

        def append(nodes)
          nodes.each { |node| @children << node }
          self
        end
      end
    end
  end
end
