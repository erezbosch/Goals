Rails.application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: :index
  resources :comments, only: :create
  resources :cheers, only: :create

  get "leaderboard", to: "goals#leaderboard"
end
