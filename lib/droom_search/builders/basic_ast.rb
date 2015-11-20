module DroomSearch
  module Builders
    class BasicAst
      class << self
        def perform(tree)
          search_query = {
            search: [],
            exact: [],
            except: []
          }
          return search_query unless tree.present?
          build_query(tree, search_query)
        end

        def build_query(root_node, search_query) # rubocop:disable Metrics/LineLength
          return if root_node.elements.nil?
          root_node.elements.each do |node|
            next if except_value?(node.parent)
            add_conditions(node, search_query)
            build_query(node, search_query)
          end
          search_query
        end

        def add_conditions(node, search_query) # rubocop:disable Metrics/LineLength
          search_query[:search].push node.text_value if value?(node)
          search_query[:exact].push node.text_value if exact_value?(node)
          search_query[:except].push node.text_value if except_value?(node)
        end

        def value?(target)
          target.is_a?(DroomSearch::NodeExtensions::BasicAst::Value)
        end

        def exact_value?(target)
          target.is_a?(DroomSearch::NodeExtensions::BasicAst::ExactValue)
        end

        def except_value?(target)
          target.is_a?(DroomSearch::NodeExtensions::BasicAst::ExceptValue)
        end
      end
    end
  end
end
