Rails.application.routes.draw do

  get 'likes/create'

  get 'likes/destroy'

  get 'password_resets/new'

  get 'password_resets/edit'

  root "sessions#new"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "home", to: "static_pages#home"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :likes, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
