Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'auction_items#index'
  # get '/auction_items/:id', to: 'auction_items#show'
  # get '/auction_items/:id', to: 'auction_items#update'
  resources :auction_items, only: [:index, :show, :edit, :update]

  # authentication routes
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
end
