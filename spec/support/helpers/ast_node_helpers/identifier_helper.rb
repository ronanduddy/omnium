# frozen_string_literal: true

require 'parser/ast/identifier'

module Helpers
  module AstNodeHelpers
    module IdentifierHelper
      include Parser::AST

      def identifier_node(token)
        Identifier.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::IdentifierHelper
end
