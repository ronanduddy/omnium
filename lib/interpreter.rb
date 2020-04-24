#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require_relative 'interpreter/lexer'
require_relative 'interpreter/parser'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    lexer = Interpreter::Lexer.new(input)
    parser = Interpreter::Parser.new(lexer.tokens)
    puts parser.parse
  rescue StandardError => e
    puts e.message
  end
end
