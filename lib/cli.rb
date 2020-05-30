# frozen_string_literal: true

module CLI
  require 'cli/core'

  def self.new(args)
    CLI::Core.new(args)
  end
end
