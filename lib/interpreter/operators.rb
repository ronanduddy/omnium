# frozen_string_literal: true

module Interpreter
  # A single place to represent operators and some sharable behaviour.
  module Operators
    SYMBOLS = {
      plus: '+',
      minus: '-',
      multiply: '*',
      divide: '/'
    }.freeze

    def plus?(character)
      character == SYMBOLS[:plus]
    end

    def minus?(character)
      character == SYMBOLS[:minus]
    end

    def multiply?(character)
      character == SYMBOLS[:multiply]
    end

    def divide?(character)
      character == SYMBOLS[:divide]
    end

    def plus_or_minus?(character)
      plus?(character) || minus?(character)
    end

    def multiply_or_divide?(character)
      multiply?(character) || divide?(character)
    end

    def operator?(character)
      SYMBOLS.values.include?(character)
    end
  end
end
