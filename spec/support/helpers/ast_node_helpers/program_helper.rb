# frozen_string_literal: true

module Helpers
  module AstNodeHelpers
    module ProgramHelper
      def program_node(name:, block:)
        Parser::AST::Program.new(name, block)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::ProgramHelper
end
