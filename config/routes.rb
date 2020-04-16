Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    # delete '/dashboard/posts/:id', to: 'posts#destroy'
    resources :posts, only: [:index, :destroy]
  end

  namespace :profile do
    get '/', to: 'dashboard#index'
    resources :stats, only: [:index]
    resources :group, only: [:new, :create]
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:index, :show, :create] do
    resources :reactions, only: [:create, :destroy]
  end
end
