# frozen_string_literal: true

# A token is a string with an assigned and identified meaning.
class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end
end
