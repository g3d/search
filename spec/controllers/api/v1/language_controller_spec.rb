require 'rails_helper'

RSpec.describe Api::V1::LanguageController, type: :controller do
  describe 'GET index' do
    it 'render index page correctly with auth_token' do
      get :index, format: :json, search: {query: ''}, auth_token: Rails.application.secrets.api_token

      expect(response.status).to eq 200
    end

    it 'return 500 if token missing' do
      get :index, format: :json

      expect(response.status).to eq 401
      result = JSON.parse(response.body)
      expect(result['error']).to eq 'Request unauthorized'
      expect(result['error_code']).to eq 'request_unauthorized'
    end
  end

end
