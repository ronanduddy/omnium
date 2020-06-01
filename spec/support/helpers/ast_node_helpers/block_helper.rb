# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module BlockHelper
      def block_node(variable_declarations:, compound_statement:)
        Parser::AST::Block.new(variable_declarations, compound_statement)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::BlockHelper
end
