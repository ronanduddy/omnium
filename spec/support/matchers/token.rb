# frozen_string_literal: true

require 'rspec/expectations'
require 'pluck/common'

RSpec::Matchers.define :be_a_token do |type, value|
  match do |actual|
    actual.type == type && actual.value == value
  end
end

Pluck::Common::VALUE_BASED_TOKENS.each do |token|
  RSpec::Matchers.define "be_a_#{token[:type]}_token" do
    match do |actual|
      actual.type == token[:type] && actual.value == token[:value]
    end
  end
end

Pluck::Common::PARAMETERISED_TOKENS.each do |token|
  RSpec::Matchers.define "be_a_#{token[:type]}_token" do |value|
    match do |actual|
      actual.type == token[:type] && actual.value == value
    end
  end
end

Pluck::Common::NIL_VALUE_TOKENS.each do |token|
  RSpec::Matchers.define "be_a_#{token[:type]}_token" do
    match do |actual|
      actual.type == token[:type] && actual.value.nil?
    end
  end
end

Pluck::Common::RESERVED_KEYWORDS.each_pair do |key, value|
  RSpec::Matchers.define "be_a_#{key}_token" do
    match do |actual|
      actual.type == key && actual.value == value
    end
  end
end
