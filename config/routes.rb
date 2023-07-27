Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :cars
      resources :users,param: :username, only: [:show, :create, :destroy] do
        resources :reservations, only: [:index, :create, :destroy]
      end
    end
  end
end
