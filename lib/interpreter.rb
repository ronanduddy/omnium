# frozen_string_literal: true

require 'node_visitor'

# The visitor pattern is used to traverse the AST. This class may be thought of
# as a 'tree visitor'.
class Interpreter < NodeVisitor
  include Common

  def initialize(parser)
    @parser = parser
  end

  def interpret
    tree = @parser.parse
    visit(tree)
  end

  # concrete visitor operations below

  def visit_Number(node)
    node.value
  end

  def visit_UnaryOperator(node)
    @type = node.operator.type

    if plus?
      +visit(node.operand)
    elsif minus?
      -visit(node.operand)
    end
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
end
