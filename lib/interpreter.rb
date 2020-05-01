#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'lexer'
require 'parser'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    lexer = Lexer.new(input)
    parser = Parser.new(lexer)
    puts parser.parse
  rescue StandardError => e
    puts e.message
  end
end
