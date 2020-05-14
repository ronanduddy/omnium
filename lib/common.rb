# frozen_string_literal: true

module Common
  # tokens that have a value
  VALUE_BASED_TOKENS = [
    { type: :plus, value: '+' },
    { type: :minus, value: '-' },
    { type: :multiply, value: '*' },
    { type: :divide, value: '/' },
    { type: :left_parenthesis, value: '(' },
    { type: :right_parenthesis, value: ')' },
    { type: :semicolon, value: ';' },
    { type: :dot, value: '.' },
    { type: :assignment, value: ':=' }
  ].freeze

  # tokens that would have a value passed into them
  PARAMETERISED_TOKENS = [
    { type: :identifier },
    { type: :integer }
  ].freeze

  # tokens that would have a value of nil
  NIL_VALUE_TOKENS = [
    { type: :eof, value: nil }
  ].freeze

  TOKENS = []
           .push(VALUE_BASED_TOKENS)
           .push(PARAMETERISED_TOKENS)
           .push(NIL_VALUE_TOKENS)
           .flatten

  RESERVED_KEYWORDS = {
    begin: 'begin',
    end: 'end'
  }.freeze

  def token_entity
    # returns e.g. :plus for @token or @type or e.g. '+' for @character
    if instance_variable_defined?(:@character)
      @character # Lexer#character
    elsif instance_variable_defined?(:@token)
      @token&.type # Parser::Core#token
    elsif instance_variable_defined?(:@type)
      @type # Interpreter#type
    end
  end

  # create helper methods from VALUE_BASED_TOKENS
  VALUE_BASED_TOKENS.each do |token|
    # for plus?, for example, return true if @character is '+' or @type is :plus
    define_method "#{token[:type]}?" do
      token_entity == token[:type] || token_entity == token[:value]
    end

    # for plus_token, for example, return :plus
    # for plus_token(:value), for example, return '+'
    define_method "#{token[:type]}_token" do |symbol = :type|
      return token[:type] if symbol == :type
      return token[:value] if symbol == :value

      raise(ArgumentError, "Invalid argument :#{symbol}")
    end
  end

  # create helper methods from PARAMETERISED_TOKENS
  PARAMETERISED_TOKENS.each do |token|
    # for integer?, for example, return true if @type is :plus
    define_method "#{token[:type]}?" do
      token_entity == token[:type]
    end

    # for integer_token, for example, return :integer
    define_method "#{token[:type]}_token" do
      token[:type]
    end
  end

  # create helper methods from RESERVED_KEYWORDS
  RESERVED_KEYWORDS.each_pair do |key, _value|
    # for begin_token, for example, return :begin
    define_method "#{key}_token" do
      key
    end
  end
end
