module DroomSearch
  # main idea is to create maintainable solution with expandable interface
  class Service
    attr_reader :options, :processor, :builder, :engine

    def initialize(options = {})
      @options = _default_options.merge(options).with_indifferent_access
      # We can pass snake case in options and prepare constants in separate
      # methods, with
      # "DroomSearch::Processors::#{options[:processor].camelize}".constantize
      # but IMO, DI is better
      @processor = @options.fetch(:processor).new @options.fetch(:grammar)
      @builder = @options.fetch(:builder)
      @engine = @options.fetch(:engine).new @options.fetch(:pagination)
      self
    end

    def perform(search_query_string)
      # At first step we convert string with rules into ast tree
      # we can use different grammars here, so extending existing grammar or
      # writing new one is quite straightforward
      ast = processor.perform search_query_string
      # Then we build search query from ast and process it by engine
      # we can easily replace query builder according to engine we use
      engine.perform builder.perform(ast)
    end

    private

    def _default_options
      # we can load default options from file, secrets.yml, any other source
      # or just return hash here
      {
        grammar: DroomSearch::Grammars::BasicAstParser.new,
        processor: DroomSearch::Processors::BasicAst,
        builder: DroomSearch::Builders::BasicAst,
        engine: DroomSearch::Engines::InMemorySearch,
        pagination: {}
      }
    end
  end
end
