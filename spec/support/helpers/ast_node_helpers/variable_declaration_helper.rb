# frozen_string_literal: true

require 'parser/ast/variable_declaration'

module Helpers
  module AstNodeHelpers
    module VariableDeclarationHelper
      include Parser::AST

      def variable_declaration_node(identifier:, data_type:)
        VariableDeclaration.new(identifier, data_type)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::VariableDeclarationHelper
end
