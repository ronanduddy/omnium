# frozen_string_literal: true

require 'pluck/parser/ast/variable_declaration'

module Helpers
  module AstNodeHelpers
    module VariableDeclarationHelper
      def variable_declaration_node(identifier:, data_type:)
        Pluck::Parser::AST::VariableDeclaration.new(identifier, data_type)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::VariableDeclarationHelper
end
