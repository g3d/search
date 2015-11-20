module Api
  module V1
    class LanguageController < Api::V1::BaseController
      def index
        @results = DroomSearch::Service.new.perform search_params['query']
      end

      private

      def search_params
        params.require(:search).permit(:query)
      end
    end
  end
end
