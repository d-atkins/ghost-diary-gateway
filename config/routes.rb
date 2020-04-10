Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#create'

  namespace :profile do
    resources :stats, only: [:index]
    resources :group, only: [:new, :create]
  end
end
