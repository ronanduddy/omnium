# frozen_string_literal: true

require_relative 'base'

module Parser
  module AST
    # This compound statement is for a 'begin ... end' block and therefore
    # represents a list of statement nodes as @children.
    class Compound < Base
      attr_reader :children

      def initialize
        @children = []
      end
    end
  end
end
