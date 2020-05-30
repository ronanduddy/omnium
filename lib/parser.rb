# frozen_string_literal: true

module Parser
  module AST
    require 'parser/ast/base'
    require 'parser/ast/assignment'
    require 'parser/ast/binary_operator'
    require 'parser/ast/block'
    require 'parser/ast/compound'
    require 'parser/ast/data_type'
    require 'parser/ast/identifier'
    require 'parser/ast/no_operation'
    require 'parser/ast/number'
    require 'parser/ast/program'
    require 'parser/ast/unary_operator'
    require 'parser/ast/variable_declaration'
  end

  require 'parser/parse_error_handler'
  require 'parser/core'

  def self.new(lexer)
    Parser::Core.new(lexer)
  end
end
