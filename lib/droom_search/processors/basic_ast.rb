module DroomSearch
  module Processors
    class BasicAst
      attr_reader :parser

      def initialize(grammar_parser)
        @parser = grammar_parser
      end

      def perform(statement)
        tree = parser.parse(statement)
        tree = clean_tree(tree) unless tree.nil?
        tree
      end

      def clean_tree(root_node)
        return if root_node.elements.nil?
        # Clean all default ast nodes, allow only nodes created by us
        root_node.elements.delete_if { |node| node.extension_modules.empty? }
        root_node.elements.each { |node| clean_tree(node) }
        root_node
      end
    end
  end
end
