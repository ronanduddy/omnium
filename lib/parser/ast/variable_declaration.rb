# frozen_string_literal: true

module Parser
  module AST
    # Representative of the declaration of a variable, containing a reference to
    # the variable identifier_node and it's data type.
    class VariableDeclaration < Base
      attr_reader :identifier, :data_type

      def initialize(identifier, data_type)
        @identifier = identifier
        @data_type = data_type
      end
    end
  end
end
