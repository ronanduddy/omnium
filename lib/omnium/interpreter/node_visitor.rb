# frozen_string_literal: true

module Omnium
  module Interpreter
    # This is to facilite the visitor pattern regards double dispatching.
    class NodeVisitor
      def visit(node)
        method_name = "visit_#{class_name(node)}"
        send(method_name, node)
      rescue NameError
        raise NotImplementedError, "Subclass does not implement #{method_name}"
      end

      private

      def class_name(node)
        node.class.name.split('::').last
      end
    end
  end
end
