# frozen_string_literal: true

module Pluck
  module Parser
    module AST
      require 'pluck/parser/ast/base'
      require 'pluck/parser/ast/assignment'
      require 'pluck/parser/ast/binary_operator'
      require 'pluck/parser/ast/block'
      require 'pluck/parser/ast/compound'
      require 'pluck/parser/ast/data_type'
      require 'pluck/parser/ast/identifier'
      require 'pluck/parser/ast/no_operation'
      require 'pluck/parser/ast/number'
      require 'pluck/parser/ast/program'
      require 'pluck/parser/ast/unary_operator'
      require 'pluck/parser/ast/variable_declaration'
    end

    require 'pluck/parser/parse_error_handler'
    require 'pluck/parser/core'

    def self.new(lexer)
      Parser::Core.new(lexer)
    end
  end
end
