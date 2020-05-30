# frozen_string_literal: true

module Parser
  module AST
    require './lib/parser/ast/base'
    require './lib/parser/ast/assignment'
    require './lib/parser/ast/binary_operator'
    require './lib/parser/ast/block'
    require './lib/parser/ast/compound'
    require './lib/parser/ast/data_type'
    require './lib/parser/ast/identifier'
    require './lib/parser/ast/no_operation'
    require './lib/parser/ast/number'
    require './lib/parser/ast/program'
    require './lib/parser/ast/unary_operator'
    require './lib/parser/ast/variable_declaration'
  end

  require './lib/parser/parse_error_handler'
  require './lib/parser/core'

  def self.new(lexer)
    Parser::Core.new(lexer)
  end
end
