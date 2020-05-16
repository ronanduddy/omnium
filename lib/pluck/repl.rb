# frozen_string_literal: true

require 'common'
require 'lexer'
require 'parser'
require 'interpreter'

module Pluck
  class REPL
    def self.run(args)
      if args.empty?
        new.run_repl
      else
        new.run_from_file(args.first)
      end
    end

    def run_repl
      loop do
        begin
          print 'pluck> '
          input = gets.chomp

          break if input == 'exit'

          puts interpret(input)
        rescue StandardError => e
          puts e.message
        end
      end
    end

    def run_from_file(filename)
      program = IO.readlines(filename, chomp: true).join
      puts interpret(program)
    end

    private

    def interpret(input)
      lexer = Lexer.new(input)
      parser = Parser.new(lexer)
      interpreter = Interpreter.new(parser)
      interpreter.interpret

      interpreter.symbol_table
    end
  end
end
