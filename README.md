## README

### Set up
This project does not require DB.

How to set up:

1. `gem install bundler` (if bundler is not installed)
2. `bundle install.`
3. Enjoy it

P.S. If you are running it on production, please don't forget to run assets precompile & set such ENV variables as
- `SECRET_KEY_BASE`
- `SECRET_API_TOKEN`

### Main concept:

To create maintainable solution we use pipe, which have next parts:
- grammar
- parser, who generate abstract syntax tree (AST)
- query builder
- engine

#### Grammar
Here we can define basic operations and terms for our AST. We inject it, so we can use different grammars for different searches.

#### Parser
Parser parse user input according to grammar and generate AST. I used treetop as a dependency, but for other cases it might be useful to have the ability to switch on the fly, so we can do it.

#### Query builder
We can generate a search query for any engine we want (Solr, Sphinx, Elasticsearch, SQL query, etc). In my implementation I generated just dummy hash for in_memory engine.

#### Engine
Own engine for filtering/search/ranking or wrapper for existing one (Solr, Sphinx, Elasticsearch, SQL query).

### TODO:
1. Improve spec coverage
2. Optimize search logic
3. Add more grammars/parsers/engines
