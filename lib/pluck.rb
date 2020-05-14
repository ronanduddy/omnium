#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'lexer'
require 'parser'
require 'interpreter'

loop do
  begin
    print 'calc> '
    input = gets.chomp

    break if input == 'exit'

    lexer = Lexer::Core.new(input)
    parser = Parser::Core.new(lexer)
    interpreter = Interpreter.new(parser)
    result = interpreter.interpret

    puts result
  rescue StandardError => e
    puts e.message
  end
end
