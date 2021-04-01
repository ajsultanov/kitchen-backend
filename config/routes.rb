Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
          resources :users, only: [:index, :create, :show]
          resources :lists, only: [:index, :create, :show]
          resources :recipes, only: [:index, :show]
          post '/login', to: 'auth#create'
          get '/listRecipes', to: 'list_recipe#index'
          get '/listRecipes/:id', to: 'list_recipe#show'
          get '/search/:query', to: 'recipes#search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
