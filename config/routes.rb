Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
          resources :users, only: [:index, :create, :show] do
            resources :lists, only: [:index, :create, :show]
          end 
          resources :recipes, only: [:index, :create, :show]
          post '/login', to: 'auth#create'
          get '/auto_login', to: 'auth#auto_login'
          get '/search/:query', to: 'recipes#search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
