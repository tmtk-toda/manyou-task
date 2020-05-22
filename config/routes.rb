Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  resources :tasks
  root :to => 'tasks#index'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
