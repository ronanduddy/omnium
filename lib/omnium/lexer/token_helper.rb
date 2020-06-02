# frozen_string_literal: true

module Omnium
  module Lexer
    module TokenHelper
      include Common

      def define_new_token_method(type, value, arity = 0)
        method_name = "new_#{type}_token"

        if arity == 0
          define_method(method_name) { Token.new(type, value) }
        else
          define_method(method_name) { |argument| Token.new(type, argument) }
        end
      end

      module_function :define_new_token_method

      VALUE_BASED_TOKENS.each do |token|
        define_new_token_method(token[:type], token[:value])
      end

      PARAMETERISED_TOKENS.each do |token|
        define_new_token_method(token[:type], nil, 1)
      end

      NIL_VALUE_TOKENS.each do |token|
        define_new_token_method(token[:type], nil)
      end

      RESERVED_KEYWORDS.each_pair do |key, value|
        define_new_token_method(key, value)
      end
    end
  end
end
