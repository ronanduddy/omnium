#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'pluck/cli'

def execute(args)
  puts Pluck::CLI.new(args).run
end

if $0 == __FILE__
  raise ArgumentError, "Usage: #{$0} <filename>" unless ARGV.length == 1
  execute(ARGV)
end
