# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_a_token do |type, value|
  match do |actual|
    actual.type == type && actual.value == value
  end
end

RSpec::Matchers.define :be_an_integer_token do |value|
  match do |actual|
    actual.type == :integer && actual.value == value
  end
end

RSpec::Matchers.define :be_a_plus_token do
  match do |actual|
    actual.type == :plus && actual.value == '+'
  end
end

RSpec::Matchers.define :be_a_minus_token do
  match do |actual|
    actual.type == :minus && actual.value == '-'
  end
end

RSpec::Matchers.define :be_a_multiply_token do
  match do |actual|
    actual.type == :multiply && actual.value == '*'
  end
end

RSpec::Matchers.define :be_a_divide_token do
  match do |actual|
    actual.type == :divide && actual.value == '/'
  end
end

RSpec::Matchers.define :be_an_eof_token do
  match do |actual|
    actual.type == :eof && actual.value.nil?
  end
end
