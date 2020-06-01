# frozen_string_literal: true

module Pluck
  module CLI
    require 'pluck/cli/core'

    def self.new(args)
      CLI::Core.new(args)
    end
  end
end
