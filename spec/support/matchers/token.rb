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

RSpec::Matchers.define :be_a_left_parenthesis_token do
  match do |actual|
    actual.type == :left_parenthesis && actual.value == '('
  end
end

RSpec::Matchers.define :be_a_right_parenthesis_token do
  match do |actual|
    actual.type == :right_parenthesis && actual.value == ')'
  end
end

RSpec::Matchers.define :be_a_begin_token do
  match do |actual|
    actual.type == :begin && actual.value == 'begin'
  end
end

RSpec::Matchers.define :be_an_end_token do
  match do |actual|
    actual.type == :end && actual.value == 'end'
  end
end

RSpec::Matchers.define :be_a_dot_token do
  match do |actual|
    actual.type == :dot && actual.value == '.'
  end
end

RSpec::Matchers.define :be_a_semicolon_token do
  match do |actual|
    actual.type == :semicolon && actual.value == ';'
  end
end

RSpec::Matchers.define :be_an_assignment_token do
  match do |actual|
    actual.type == :assignment && actual.value == ':='
  end
end

RSpec::Matchers.define :be_an_identifier_token do |name|
  match do |actual|
    actual.type == :id && actual.value == name
  end
end

RSpec::Matchers.define :be_an_eof_token do
  match do |actual|
    actual.type == :eof && actual.value.nil?
  end
end
