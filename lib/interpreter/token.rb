# frozen_string_literal: true

module Interpreter
  class Token
    INTEGER = :integer
    PLUS = :plus
    MINUS = :minus
    EOF = :eof

    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value # 0-9, +, -, nil
    end

    def str
      "Token(#{type}, #{value})"
    end
  end
end
