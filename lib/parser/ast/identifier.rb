# frozen_string_literal: true

module Parser
  module AST
    # This node represents a variable or an identifier, accepting an ID token.
    class Identifier < Base
      attr_reader :name

      def initialize(token)
        @token = token # for convenience, though no getter for this
        @name = token.value
      end
    end
  end
end
