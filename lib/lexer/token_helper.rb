# frozen_string_literal: true

module Lexer
  module TokenHelper
    include Common

    # I wonder could this module be converted to use the builder pattern or
    # something... perhaps this reflection-metaprogammy stuff has went to my head.

    # create helper methods from TOKENS to return tokens
    # e.g. integer_token(3) or plus_token
    TOKENS.each do |token|
      define_method "new_#{token[:type]}_token" do |value = nil|
        Token.new(token[:type], token[:value] || value)
      end
    end

    # create helper methods from RESERVED_KEYWORDS to return reserved keyword
    # tokens e.g. begin_token
    RESERVED_KEYWORDS.each_pair do |key, value|
      define_method "new_#{key}_token" do
        Token.new(key, value)
      end
    end
  end
end
