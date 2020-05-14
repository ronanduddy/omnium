# frozen_string_literal: true

require 'parser/ast/no_operation'

module Helpers
  module AstNodeHelpers
    module NoOperationHelper
      include Parser::AST

      def noop_node
        NoOperation.new
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::NoOperationHelper
end
