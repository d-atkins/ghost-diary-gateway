Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#create'

  get '/profile', to: 'users#show'
  get '/profile/stats', to: 'user/stats#index'
  get '/profile/posts', to: 'user/posts#index'

  namespace :profile do
    resources :stats, only: [:index]
  end
end
