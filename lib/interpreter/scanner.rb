# frozen_string_literal: true

module Interpreter
  # Provides scanning operations on a string. Note StringScanner could just be
  # used from strscan rather than doing all this... but where would the fun be
  # in that.
  class Scanner
    WHITESPACE = ' '

    attr_accessor :string, :pointer

    def initialize(string)
      @string = string
      @pointer = 0
    end

    def eos?
      @pointer > @string.length - 1
    end

    def scan
      return nil if eos?

      advance while whitespace?

      term = ''
      (@pointer...@string.length).each do
        break if whitespace?

        term += consume
      end

      term
    end

    private

    def consume
      char = character
      advance
      char
    end

    def advance
      @pointer += 1
    end

    def character
      @string[@pointer]
    end

    def whitespace?
      WHITESPACE == character
    end
  end
end
