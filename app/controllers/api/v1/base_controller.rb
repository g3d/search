module Api
  module V1
    class BaseController < ApplicationController
      prepend_before_action :auth_token
      before_action :authenticate_user!

      rescue_from ActionController::ParameterMissing do |exception|
        render json: {
          error: exception.message,
          error_code: 'params_missing'
        }, status: 500
      end

      private

      def authenticate_user!
        # TODO: Crate api auth
        return if params[:auth_token] == Rails.application.secrets.api_token
        render json: {
          error: 'Request unauthorized',
          error_code: 'request_unauthorized'
        }, status: 401
      end

      def auth_token
        auth_token = params[:auth_token].blank? && headers['X-AUTH-TOKEN']
        params[:auth_token] = auth_token if auth_token
      end
    end
  end
end
