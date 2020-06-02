# frozen_string_literal: true

module Omnium
  module Parser
    module AST
      require 'omnium/parser/ast/base'
      require 'omnium/parser/ast/assignment'
      require 'omnium/parser/ast/binary_operator'
      require 'omnium/parser/ast/block'
      require 'omnium/parser/ast/compound'
      require 'omnium/parser/ast/data_type'
      require 'omnium/parser/ast/identifier'
      require 'omnium/parser/ast/no_operation'
      require 'omnium/parser/ast/number'
      require 'omnium/parser/ast/program'
      require 'omnium/parser/ast/unary_operator'
      require 'omnium/parser/ast/variable_declaration'
    end

    require 'omnium/parser/parse_error_handler'
    require 'omnium/parser/core'

    def self.new(lexer)
      Parser::Core.new(lexer)
    end
  end
end
