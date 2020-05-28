# frozen_string_literal: true

require 'parser/ast/block'

module Helpers
  module AstNodeHelpers
    module BlockHelper
      include Parser::AST

      def block_node(variable_declarations:, compound_statements:)
        Block.new(variable_declarations, compound_statements)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::BlockHelper
end
