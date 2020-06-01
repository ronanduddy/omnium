# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module CompoundHelper
      def compound_node(nodes)
        Parser::AST::Compound.new.append(nodes)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::CompoundHelper
end
