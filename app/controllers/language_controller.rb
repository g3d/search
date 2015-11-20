class LanguageController < ApplicationController
  def index
    @results = Language.all
  end

  def search
    @results = DroomSearch::Service.new.perform search_params['query']
    # Fallback to html if js is disabled
    render :index
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
