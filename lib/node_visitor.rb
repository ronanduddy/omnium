# frozen_string_literal: true

# This is to facilite the visitor pattern regards double dispatching.
class NodeVisitor
  def visit(node)
    method_name = "visit_#{node.class.name}"
    send(method_name, node)
  rescue NameError => e
    raise NotImplementedError, "Subclass does not implement #{method_name}"
  end
end
