# frozen_string_literal: true

require 'parser/ast/number'

module Helpers
  module AstNodeHelpers
    module NumberHelper
      include Parser::AST

      def number_node(token)
        Number.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::NumberHelper
end
