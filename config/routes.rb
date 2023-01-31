Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index]
  get 'article_likes/create'
  get 'article_likes/destroy'
  root 'static_pages#home'
  get       "/home",    to: "static_pages#home"
  get       "/help",    to: "static_pages#help"
  get       "/about",   to: "static_pages#about"
  get       "/contact", to: "static_pages#contact"
  get       "/search",  to: "searchs#search"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :articles, only: %i[new create destroy]
  resources :relationships, only: %i[create destroy]
  get '/articles', to: 'static_pages#home'
  resources :article_likes, only: %i[create destroy]
end
