# frozen_string_literal: true

require_relative 'base'

module Parser
  module AST
    # An integer node.
    class Number < Base
      attr_reader :value

      def initialize(token)
        @token = token # for convenience
        @value = token.value
      end
    end
  end
end
