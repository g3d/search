module DroomSearch
  module NodeExtensions
    module BasicAst
      class Word < Treetop::Runtime::SyntaxNode
      end

      class Term < Treetop::Runtime::SyntaxNode
      end

      class ExactValue < Treetop::Runtime::SyntaxNode
        def text_value
          super.delete '"'
        end
      end

      class ExceptValue < Treetop::Runtime::SyntaxNode
        def text_value
          elements.first.text_value
        end
      end

      class Search < Treetop::Runtime::SyntaxNode
      end

      class Value < Treetop::Runtime::SyntaxNode
      end
    end
  end
end
