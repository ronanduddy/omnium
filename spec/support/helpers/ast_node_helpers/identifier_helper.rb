# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module IdentifierHelper
      def identifier_node(token)
        Parser::AST::Identifier.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::IdentifierHelper
end
