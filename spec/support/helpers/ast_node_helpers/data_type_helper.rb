# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module DataTypeHelper
      def data_type_node(token)
        Parser::AST::DataType.new(token)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::DataTypeHelper
end
