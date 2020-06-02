# frozen_string_literal: true

module Omnium
  module CLI
    require 'omnium/cli/core'

    def self.new(args)
      CLI::Core.new(args)
    end
  end
end
