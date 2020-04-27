# frozen_string_literal: true

module Interpreter
  # A token is a string with an assigned and identified meaning.
  # Common token names are:
  #   identifier: names the programmer chooses;
  #   keyword: names already in the programming language;
  #   separator (also known as punctuators): punctuation characters and
  #     paired-delimiters;
  #   operator: symbols that operate on arguments and produce results;
  #   literal: numeric, logical, textual, reference literals;
  #   comment: line, block.
  # The value of a token can be thought of as a lexeme.
  class Token
    require_relative 'operators'
    include Operators

    EOF = :eof

    attr_reader :type, :value

    def initialize(type, value)
      @type = type
      @value = value
    end

    def operator?
      super(value)
    end

    def eof?
      type == EOF # should this be centralised?
    end
  end
end
