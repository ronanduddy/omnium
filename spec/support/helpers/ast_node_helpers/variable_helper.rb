# frozen_string_literal: true

require 'parser/ast/variable'

module Helpers
  module AstNodeHelpers
    module VariableHelper
      include Parser::AST

      def variable_node(token)
        Variable.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::VariableHelper
end
