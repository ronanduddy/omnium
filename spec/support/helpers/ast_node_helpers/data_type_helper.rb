# frozen_string_literal: true

require 'parser/ast/data_type'

module Helpers
  module AstNodeHelpers
    module DataTypeHelper
      include Parser::AST

      def data_type_node(token)
        DataType.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::DataTypeHelper
end
