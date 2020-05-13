# frozen_string_literal: true

require_relative 'base'

module Parser
  module AST
    # This node represents a variable, accepting an ID token.
    class Variable < Base
      attr_reader :value

      def initialize
        @token = token # for convenience, though no getter for this
        @value = token.value
      end
    end
  end
end
