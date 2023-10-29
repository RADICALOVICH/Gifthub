Rails.application.routes.draw do
  resources :wishes
  resources :groups
  devise_for :users
  root 'home#index'
  
  post 'groups/list_of_users/:id', to: 'groups#list_of_users'
  post 'groups/calendar/:id', to: 'groups#calendar'
  post 'groups/information/:id', to: 'groups#information'
  get 'groups/:id/add_user', to: 'groups#add_user', as: 'invite_user'
  get 'groups/:id/invite_users', to: 'groups#invite_users'
  post 'groups/send_email', to: 'groups#send_email'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
