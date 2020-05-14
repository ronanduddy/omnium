# frozen_string_literal: true

require 'token'

module Common
  # tokens that have a value
  VALUE_BASED_TOKENS = {
    plus: { type: :plus, value: '+' },
    minus: { type: :minus, value: '-' },
    multiply: { type: :multiply, value: '*' },
    divide: { type: :divide, value: '/' },
    left_parenthesis: { type: :left_parenthesis, value: '(' },
    right_parenthesis: { type: :right_parenthesis, value: ')' },
    semicolon: { type: :semicolon, value: ';' },
    dot: { type: :dot, value: '.' },
    assignment: { type: :assignment, value: ':=' }
  }.freeze

  # tokens that would have a value passed into them
  PARAMETERISED_TOKENS = {
    identifier: { type: :identifier },
    integer: { type: :integer }
  }.freeze

  # tokens that would have a value of nil
  NIL_VALUE_TOKENS = {
    eof: { type: :eof, value: nil }
  }.freeze

  TOKENS = {}
           .merge(VALUE_BASED_TOKENS)
           .merge(PARAMETERISED_TOKENS)
           .merge(NIL_VALUE_TOKENS)

  RESERVED_KEYWORDS = {
    begin: 'begin',
    end: 'end'
  }.freeze

  WHITESPACE = ' '

  # create helper methods from VALUE_BASED_TOKENS
  # e.g. if @character = '+' then plus? will return true
  VALUE_BASED_TOKENS.each_pair do |key, token|
    define_method "#{key}?" do
      token_entity == token[:type] || token_entity == token[:value]
    end
  end

  # create helper methods from PARAMETERISED_TOKENS
  # e.g. if @type = :integer then integer? will return true
  PARAMETERISED_TOKENS.each_pair do |key, token|
    define_method "#{key}?" do
      token_entity == token[:type]
    end
  end

  def token_entity
    # Lexer#character, Parser::Core#token, and Interpreter#type
    # e.g. :plus or '+'
    @character || @token&.type || @type
  end

  # create helper methods from TOKENS to return tokens
  # e.g. integer_token(3) or plus_token
  TOKENS.each_pair do |key, token|
    define_method "#{key}_token" do |value = nil|
      Token.new(token[:type], token[:value] || value)
    end
  end

  # create helper methods from RESERVED_KEYWORDS to return reserved keyword tokens
  # e.g. begin_token
  RESERVED_KEYWORDS.each_pair do |key, value|
    define_method "#{key}_token" do
      Token.new(key, value)
    end
  end
end
