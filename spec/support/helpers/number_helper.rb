# frozen_string_literal: true

require 'number'

module Helpers
  module NumberHelper
    def number_node(token)
      Number.new(token)
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::NumberHelper
end
