# frozen_string_literal: true

module Interpreter
  # The visitor pattern is used to traverse the AST. This class may be thought of
  # as a 'tree visitor'.
  class Core < NodeVisitor
    include Common

    class InterpreterError < StandardError; end

    attr_reader :symbol_table

    def initialize(parser)
      @parser = parser
      @symbol_table = {}
    end

    def interpret
      tree = @parser.parse
      visit(tree)
    end

    # concrete visitor operations below

    def visit_Compound(node)
      node.children.each { |child| visit(child) }
    end

    def visit_Assignment(node)
      symbol_table[node.left.name.intern] = visit(node.right)
    end

    def visit_Variable(node)
      symbol_table.fetch(node.name.intern)
    rescue KeyError
      raise(InterpreterError, "Variable '#{node.name}' not found")
    end

    def visit_NoOperation(node)
      # noop
    end

    def visit_BinaryOperator(node)
      @type = node.operator.type

      if plus?
        visit(node.left) + visit(node.right)
      elsif minus?
        visit(node.left) - visit(node.right)
      elsif multiply?
        visit(node.left) * visit(node.right)
      elsif divide?
        visit(node.left) / visit(node.right)
      end
    end

    def visit_UnaryOperator(node)
      @type = node.operator.type

      if plus?
        +visit(node.operand)
      elsif minus?
        -visit(node.operand)
      end
    end

    def visit_Number(node)
      node.value
    end
  end
end
