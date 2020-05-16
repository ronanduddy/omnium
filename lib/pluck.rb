#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << './lib'

require 'pry'
require 'pluck/repl'

module Pluck
  Pluck::REPL.run(ARGV)
end
