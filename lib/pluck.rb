#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'common'
require 'lexer'
require 'parser'
require 'interpreter'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    lexer = Lexer.new(input)
    parser = Parser.new(lexer)
    interpreter = Interpreter.new(parser)
    result = interpreter.interpret

    puts result
  rescue StandardError => e
    puts e.message
  end
end
