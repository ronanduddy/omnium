# frozen_string_literal: true

module Omnium
  module Parser
    module AST
      # Int or float for example
      class DataType < Base
        attr_reader :value

        def initialize(token)
          @value = token.value
        end
      end
    end
  end
end
