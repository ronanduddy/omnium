# frozen_string_literal: true

module CLI
  require './lib/cli/core'

  def self.new(args)
    CLI::Core.new(args)
  end
end
