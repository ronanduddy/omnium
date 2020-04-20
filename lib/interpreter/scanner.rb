# frozen_string_literal: true

module Interpreter
  # Provides scanning operations on a string. Note StringScanner could just be
  # used from strscan rather than doing all this... but where would the fun be
  # in that.
  class Scanner
    require_relative 'operators'
    include Operators

    WHITESPACE = ' '

    attr_accessor :string, :pointer

    def initialize(string)
      @string = string
      @pointer = 0
    end

    def reset
      @pointer = 0
    end

    def eos?
      pointer > string.length - 1
    end

    #  these scan_* methods could be merged
    def next_char
      return nil if eos?

      character = string[pointer]
      increment_pointer
      character
    end

    def next_word(skip_whitespace = true)
      return nil if eos?

      next_whitespace if skip_whitespace

      word = []
      (pointer...string.length).each do |index|
        character = string[index]
        break if delimiter?(character)

        increment_pointer
        word << character
      end

      return nil if word.empty?

      word.join
    end

    def next_operator(skip_whitespace = true)
      return nil if eos?

      next_whitespace if skip_whitespace
      character = string[pointer]
      return nil unless operator?(character)

      increment_pointer
      character
    end

    def next_whitespace
      return nil if eos?

      whitespaces = []

      (pointer...string.length).each do |index|
        character = string[index]
        break nil unless whitespace?(character)

        increment_pointer
        whitespaces << character
      end

      return nil if whitespaces.empty?

      whitespaces.join
    end

    private

    def increment_pointer
      @pointer += 1
    end

    def delimiter?(character)
      return true if operator?(character)
      return true if whitespace?(character)

      false
    end

    def whitespace?(character)
      WHITESPACE == character
    end
  end
end
