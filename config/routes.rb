Rails.application.routes.draw do
  resources :wishes
  resources :groups
  devise_for :users
  root 'home#index'
  
  post 'groups/list_of_users/:id', to: 'groups#list_of_users'
  post 'groups/calendar/:id', to: 'groups#calendar'
  post 'groups/information/:id', to: 'groups#information'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
