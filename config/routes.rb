Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'auction_items#index'
  # get '/auction_items/:id', to: 'auction_items#show'
  # get '/auction_items/:id', to: 'auction_items#update'
  resources :auction_items, only: [:index, :show, :edit, :update]
  patch 'place_bid/:id', to: 'auction_items#place_bid', as: 'place_bid'
  get 'place_bid/:id', to: 'auction_items#edit', as: 'place_bid_edit'

  # authentication routes
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions
end
