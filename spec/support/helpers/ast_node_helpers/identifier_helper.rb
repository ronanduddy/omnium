# frozen_string_literal: true

require 'pluck/parser/ast/identifier'

module Helpers
  module AstNodeHelpers
    module IdentifierHelper
      def identifier_node(token)
        Pluck::Parser::AST::Identifier.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::IdentifierHelper
end
