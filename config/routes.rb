Rails.application.routes.draw do
  get '/Api/v1/users/:username', to: 'api/v1/users#show'
  post '/Api/v1/users', to: 'api/v1/users#create'
  delete '/Api/v1/users/:username', to: 'api/v1/users#destroy'

  get '/Api/v1/cars', to: 'api/v1/cars#index'
  post '/Api/v1/cars', to: 'api/v1/cars#create'

end
