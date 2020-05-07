# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_an_ast do |expected|
  match do |actual|
    to_hash(actual) == to_hash(expected)
  end

  def to_hash(object)
    hash = {}

    object.instance_variables.each do |variable|
      nested_object = object.instance_variable_get(variable)

      hash[variable.to_s.delete('@')] = if valid?(nested_object)
                                          nested_object
                                        else
                                          to_hash(nested_object)
                                        end
    end

    hash
  end

  def valid?(object)
    case object.class
    when Numeric || Symbol || String
      return true
    end
    false
  end
end
