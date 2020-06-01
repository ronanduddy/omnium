# frozen_string_literal: true

require 'pluck/parser/ast/block'

module Helpers
  module AstNodeHelpers
    module BlockHelper
      def block_node(variable_declarations:, compound_statement:)
        Pluck::Parser::AST::Block.new(variable_declarations, compound_statement)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::BlockHelper
end
