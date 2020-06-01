# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module AssignmentHelper
      def assignment_node(left:, operator:, right:)
        Parser::AST::Assignment.new(left, operator, right)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::AssignmentHelper
end
