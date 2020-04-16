#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require_relative 'interpreter/lexer'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    lexer = Interpreter::Lexer.new(input)
    puts lexer.evaluate
  rescue StandardError => e
    puts e.message
  end
end
