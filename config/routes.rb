Rails.application.routes.draw do
  get '/Api/v1/users/:username', to: 'api/v1/users#show'
  post '/Api/v1/users', to: 'api/v1/users#create'
  delete '/Api/v1/users/:username', to: 'api/v1/users#destroy'

  get '/Api/v1/cars', to: 'api/v1/cars#index'
  post '/Api/v1/cars', to: 'api/v1/cars#create'
  get '/Api/v1/car/:id', to: 'api/v1/cars#show'
  delete '/Api/v1/cars/:id', to:  'api/v1/cars#destroy'

  get 'Api/v1/users/:user_id/reservations', to: 'api/v1/reservations#index'
  post 'Api/v1/users/:user_id/reservations',to: 'api/v1/reservations#create'

end
