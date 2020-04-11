Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#create'

  namespace :profile do
    get '/', to: 'dashboard#index'
    resources :stats, only: [:index]
    resources :group, only: [:new, :create]
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:index, :show]
end
