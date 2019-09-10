Rails.application.routes.draw do
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/about', to:'static_pages#about'

  get '/signup', to: 'users#new'

  get '/login' ,to: 'sessions#new'

  resources :users, except: :new do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  #admin用のcontrollerとview
  namespace :admin do
    resources :categories
    resources :users
  end

end
