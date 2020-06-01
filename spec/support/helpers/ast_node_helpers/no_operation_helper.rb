# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module NoOperationHelper
      def noop_node
        Parser::AST::NoOperation.new
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::NoOperationHelper
end
