# frozen_string_literal: true

require 'parser/ast/program'

module Helpers
  module AstNodeHelpers
    module ProgramHelper
      include Parser::AST

      def program_node(name:, block:)
        Program.new(name, block)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::AstNodeHelpers::ProgramHelper
end
