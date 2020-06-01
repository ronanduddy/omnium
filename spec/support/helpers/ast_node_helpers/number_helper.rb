# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module NumberHelper
      def number_node(token)
        Parser::AST::Number.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::NumberHelper
end
