# frozen_string_literal: true

module Pluck
  module Parser
    module AST
      # A block represents declarations and compound statements
      class Block < Base
        attr_reader :variable_declarations, :compound_statement

        def initialize(variable_declarations, compound_statement)
          @variable_declarations = variable_declarations
          @compound_statement = compound_statement
        end
      end
    end
  end
end
