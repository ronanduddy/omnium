# frozen_string_literal: true

require_relative 'node_visitor'

# The visitor pattern is used to traverse the AST. This class may be thought of
# as a 'tree visitor'.
class Interpreter < NodeVisitor
  PLUS = :plus
  MINUS = :minus
  MULTIPLY = :multiply
  DIVIDE = :divide

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
    case node.operator.type
    when PLUS
      +visit(node.operand)
    when MINUS
      -visit(node.operand)
    end
  end

  def visit_BinaryOperator(node)
    case node.operator.type
    when PLUS
      visit(node.left) + visit(node.right)
    when MINUS
      visit(node.left) - visit(node.right)
    when MULTIPLY
      visit(node.left) * visit(node.right)
    when DIVIDE
      visit(node.left) / visit(node.right)
    else
      # something here...
    end
  end
end
