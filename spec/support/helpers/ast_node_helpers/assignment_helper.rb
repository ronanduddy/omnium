# frozen_string_literal: true

require 'parser/ast/assignment'

module Helpers
  module AstNodeHelpers
    module AssignmentHelper
      include Parser::AST

      def assignment_node(left:, operator:, right:)
        Assignment.new(left, operator, right)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::AssignmentHelper
end
