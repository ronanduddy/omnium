#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'pluck/cli'

def execute(args)
  puts Pluck::CLI.new(args).run
end

if $PROGRAM_NAME == __FILE__
  unless ARGV.length == 1
    raise ArgumentError, "Usage: #{$PROGRAM_NAME} <filename>"
  end

  execute(ARGV)
end
