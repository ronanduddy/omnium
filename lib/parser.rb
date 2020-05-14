# frozen_string_literal: true

module Parser
  module AST
    require 'parser/ast/base'
    require 'parser/ast/number'
    require 'parser/ast/unary_operator'
    require 'parser/ast/binary_operator'
    require 'parser/ast/assignment'
    require 'parser/ast/compound'
    require 'parser/ast/no_operation'
    require 'parser/ast/variable'
  end

  require 'parser/core'
end
