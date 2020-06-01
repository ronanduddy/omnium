# frozen_string_literal: true

require 'pluck/parser/ast/no_operation'

module Helpers
  module AstNodeHelpers
    module NoOperationHelper
      def noop_node
        Pluck::Parser::AST::NoOperation.new
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::NoOperationHelper
end
