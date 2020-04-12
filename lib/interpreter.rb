#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require_relative 'interpreter/tokeniser'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    tokeniser = Interpreter::Tokeniser.new(input)
    puts tokeniser.expression
  rescue StandardError => e
    puts e.message
  end
end
