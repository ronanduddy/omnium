# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_an_ast do |expected|
  match do |actual|
    serialise(actual) == serialise(expected)
  end

  def serialise(object)
    if primative?(object)
      object
    elsif array?(object)
      to_array(object)
    else
      to_hash(object)
    end
  end

  def to_hash(object)
    hash = {}

    object.instance_variables.each do |variable_name|
      variable = object.instance_variable_get(variable_name)
      hash[variable_name.to_s.delete('@')] = serialise(variable)
    end

    hash
  end

  def to_array(list)
    array = []

    list.each { |element| array << serialise(element) }

    array
  end

  def primative?(object)
    klass = object.class

    return true if object.is_a? Numeric
    return true if klass == Symbol
    return true if klass == String

    false
  end

  def array?(object)
    klass = object.class

    return true if klass == Array

    false
  end
end
