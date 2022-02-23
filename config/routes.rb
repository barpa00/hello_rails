Rails.application.routes.draw do
  root "missions#index"
  resources :missions

  resource :users, controller: 'registrations', only: [:new, :create] do
  end

  resource :users, controller: 'sessions', only: [] do
    get '/log_in', action: 'new'
    post '/log_in', action: 'create'
    delete '/log_out', action: 'destroy'
  end
  
end
