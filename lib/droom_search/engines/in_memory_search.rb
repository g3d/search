module DroomSearch
  module Engines
    class InMemorySearch
      attr_reader :options, :relevance_hash, :rules, :search_query
      def initialize(options = {})
        @options = options
        # TODO: Add pagination support
        @rules = _default_rules.merge(options.fetch(:rules, {}))
        # Select what key to use as item id
        @item_id = options.fetch(:item_id, 'id')
        # In relevance_hash we store elements weight
        @relevance_hash = {}
      end

      def perform(search_query)
        @search_query = search_query
        # TODO: Replace with better algo
        filtered_results = calculate_relevance filter_result(results)
        filtered_results.sort do |x, y|
          relevance_hash[y[@item_id]] <=> relevance_hash[x[@item_id]]
        end
      end

      private

      def results
        # Engine should know search source
        # Load info only once
        @results ||= Language.all
      end

      def filter_result(data)
        # select for inclusion, reject for exclusion
        _filter_options.each do |key, action|
          next unless search_query[key].present?
          data = data.public_send(action) do |item|
            at_least_one_value_present?(
              item.attributes.values,
              search_query[key]
            )
          end
        end
        data
      end

      def at_least_one_value_present?(values, items_array)
        values.any? { |value| at_least_one_present?(value, items_array) }
      end

      def at_least_one_present?(value, items_array)
        value.to_s.scan(/\b#{Array(items_array).join('|')}\b/i).present?
      end

      def calculate_relevance(target_enum)
        # calculate weight for sorting by relevance
        target_enum.each do |item|
          @relevance_hash[item.public_send(@item_id)] = relevance_for_item(item)
        end
      end

      def relevance_for_item(item)
        item_relevance = 0
        item.attributes.each do |key, value|
          search_query[:search].each do |keyword|
            next unless at_least_one_present?(value, [keyword])
            item_relevance += rules[key]
          end
        end
        item_relevance
      end

      def _filter_options
        {
          exact: :select,
          search: :select,
          except: :reject
        }
      end

      def _default_rules
        {
          'id' => 0,
          'name' => 7,
          'type' => 5,
          'designed_by' => 5
        }.with_indifferent_access
      end
    end
  end
end
