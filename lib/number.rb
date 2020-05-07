# frozen_string_literal: true

require_relative 'ast'

# An integer node.
class Number < AST
  attr_reader :value

  def initialize(token)
    @token = token # for convenience
    @value = token.value
  end
end
