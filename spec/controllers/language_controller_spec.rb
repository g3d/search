require 'rails_helper'

RSpec.describe LanguageController, type: :controller do
  describe 'GET index' do
    it 'render index page correctly' do
      get :index

      expect(response.status).to eq 200
      expect(response).to render_template(:index)
    end
  end

  describe 'POST search' do
    it 'process page with params correctly' do
      post :search, search: {query: ''}

      expect(response.status).to eq 200
      expect(response).to render_template(:index)
    end

    it 'process fails without search params' do
      post :search, search: {}

      expect(response).to redirect_to root_url
    end
  end
end
