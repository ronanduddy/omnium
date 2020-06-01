# frozen_string_literal: true

module Pluck
  module Common
    VALUE_BASED_TOKENS = [
      { type: :plus, value: '+' },
      { type: :minus, value: '-' },
      { type: :multiply, value: '*' },
      { type: :divide, value: '/' },
      { type: :left_parenthesis, value: '(' },
      { type: :right_parenthesis, value: ')' },
      { type: :semicolon, value: ';' },
      { type: :dot, value: '.' },
      { type: :assignment, value: ':=' },
      { type: :colon, value: ':' },
      { type: :comma, value: ',' }
    ].freeze

    PARAMETERISED_TOKENS = [
      { type: :identifier },
      { type: :integer }, # int
      { type: :real } # float
    ].freeze

    NIL_VALUE_TOKENS = [
      { type: :eof, value: nil }
    ].freeze

    TOKENS = {}
             .merge(value_based: VALUE_BASED_TOKENS)
             .merge(parameterised: PARAMETERISED_TOKENS)
             .merge(nil_value: NIL_VALUE_TOKENS)

    RESERVED_KEYWORDS = {
      program: 'program',
      var: 'var',
      int: 'int', # integer
      float: 'float', # real
      begin: 'begin',
      end: 'end'
    }.freeze

    def token_entity
      if instance_variable_defined?(:@character)
        @character # Lexer#character
      elsif instance_variable_defined?(:@token)
        @token&.type # Parser::Core#token
      elsif instance_variable_defined?(:@type)
        @type # Interpreter#type
      end
    end

    def define_token_predicate_method(type, value = nil)
      define_method("#{type}?") do
        token_entity == type || (!value.nil? && token_entity == value)
      end
    end

    def define_token_type_method(type)
      define_method("#{type}_token") { type }
    end

    module_function :token_entity, :define_token_predicate_method, :define_token_type_method

    VALUE_BASED_TOKENS.each do |token|
      define_token_predicate_method(token[:type], token[:value])

      define_method("#{token[:type]}_token") do |symbol = :type|
        return token[:type] if symbol == :type
        return token[:value] if symbol == :value

        raise(ArgumentError, "Invalid argument :#{symbol}")
      end
    end

    PARAMETERISED_TOKENS.each do |token|
      define_token_predicate_method(token[:type])
      define_token_type_method(token[:type])
    end

    NIL_VALUE_TOKENS.each do |token|
      define_token_predicate_method(token[:type])
      define_token_type_method(token[:type])
    end

    RESERVED_KEYWORDS.each_pair do |key, _value|
      define_token_predicate_method(key)
      define_token_type_method(key)
    end
  end
end
