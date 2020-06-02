# frozen_string_literal: true

module Omnium
  module CLI
    class Core
      class CLIError < StandardError; end

      def initialize(args)
        @filename = args&.first
      end

      def run
        program = IO.readlines(@filename).join

        interpret(program)
      rescue TypeError => e
        raise(CLIError, '@filename is blank.')
      rescue Errno::ENOENT => e
        raise(CLIError, "@filename '#{@filename}' does not exist.")
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
end
