# frozen_string_literal: true

module Parser
  module AST
    # Program represents the root node.
    class Program < Base
      attr_reader :name, :block

      def initialize(name, block)
        @name = name
        @block = block
      end
    end
  end
end
