# frozen_string_literal: true

module Parser
  module AST
    # A block represents declarations and compound statements
    class Block < Base
      attr_reader :variable_declarations, :compound_statements

      def initialize(variable_declarations, compound_statements)
        @variable_declarations = variable_declarations
        @compound_statements = compound_statements
      end
    end
  end
end
