# frozen_string_literal: true

module Omnium
  module Parser
    module AST
      # This is an assignment statement, for example 'x := 5' or 'y := x'. @left
      # is a reference to the variable node and @right is a reference to the node
      # returned by Parser::Core#expr
      class Assignment < Base
        attr_reader :left, :operator, :right

        def initialize(left, operator, right)
          @left = left
          @operator = operator
          @right = right
        end
      end
    end
  end
end
