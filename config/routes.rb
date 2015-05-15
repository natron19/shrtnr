require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'dashboard' => 'dashboards#index', as: :dashboard
  get 'home' => 'dashboards#home', as: :home
  get 'all' => 'dashboards#all', as: :all

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  put '/settings/new_api_key' => 'settings#new_api_key', as: :new_api_key

  # oauth
  get 'auth/twitter/callback', to: 'sessions#twitter', as: :twitter_auth
  get 'auth/failure', to: 'sessions#failure'

  resources :users, only: [:new, :create]
  get '/settings' => 'settings#index', as: :settings
  post '/settings' => 'settings#update'

  resources :links, only: [:create, :show, :redirection, :destroy]

  get '/:id' => 'links#redirection', as: :redirect_url

  # api
  namespace :api do
    namespace :v1 do
      get 'links/create'
      get 'links/:id' => 'links#show' 
      get 'users/:id' => 'users#show' 
    end
  end

  root 'sessions#direct'
end
