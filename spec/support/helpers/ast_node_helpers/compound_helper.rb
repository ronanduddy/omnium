# frozen_string_literal: true

require 'pluck/parser/ast/compound'

module Helpers
  module AstNodeHelpers
    module CompoundHelper
      def compound_node(nodes)
        Pluck::Parser::AST::Compound.new.append(nodes)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::CompoundHelper
end
