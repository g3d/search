Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :language, only: [:index] do
    post :search, on: :collection
  end

  root 'language#index'

  namespace :api do
    namespace :v1 do
      resources :language, only: [:index]
    end
  end
end
