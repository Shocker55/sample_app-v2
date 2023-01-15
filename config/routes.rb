Rails.application.routes.draw do
  get 'article_likes/create'
  get 'article_likes/destroy'
  get 'sessions/new'
  get 'users/new'
  root "static_pages#home"
  get       "/home",    to: "static_pages#home"
  get       "/help",    to: "static_pages#help"
  get       "/about",   to: "static_pages#about"
  get       "/contact", to: "static_pages#contact"
  get       "/signup",  to: "users#new"
  get       "/search",  to: "users#search"
  get       "/login",   to: "sessions#new"
  post      "/login",   to: "sessions#create"
  delete    "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :articles,    only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get '/articles', to: 'static_pages#home'
  resources :article_likes, only: [:create, :destroy]
end
