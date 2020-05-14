# frozen_string_literal: true

require 'parser/ast/compound'

module Helpers
  module AstNodeHelpers
    module CompoundHelper
      include Parser::AST

      def compound_node
        Compound.new
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::CompoundHelper
end
