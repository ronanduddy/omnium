# frozen_string_literal: true

module Pluck
  module Parser
    module AST
      # An integer node, which would accept an integer/number token.
      class Number < Base
        attr_reader :value

        def initialize(token)
          @token = token # for convenience, though no getter for this
          @value = token.value
        end
      end
    end
  end
end
