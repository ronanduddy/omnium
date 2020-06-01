# frozen_string_literal: true

require 'pluck/parser/ast/assignment'

module Helpers
  module AstNodeHelpers
    module AssignmentHelper
      def assignment_node(left:, operator:, right:)
        Pluck::Parser::AST::Assignment.new(left, operator, right)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::AssignmentHelper
end
