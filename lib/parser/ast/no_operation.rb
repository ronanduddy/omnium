# frozen_string_literal: true

module Parser
  module AST
    # This class represents no operation, nothing, a noop, an empty statement
    # such as 'begin end'.
    class NoOperation < Base
      # noop
    end
  end
end
