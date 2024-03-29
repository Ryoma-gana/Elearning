Rails.application.routes.draw do
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/about', to:'static_pages#about'

  get '/signup', to: 'users#new'

  get '/login' ,to: 'sessions#new'

  

  resources :users, except: :new do
    resources :words, only: :index
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :categories

  resources :lessons, only: [:create, :show] do 
    resources :answers
  end

  #admin用のcontrollerとview
  namespace :admin do
    resources :users, only: [:index, :update, :destroy]
    resources :categories do
      resources :words do
        resources :choices
      end
    end
  end

  resources :categories do
    # resources :words
    resources :choices
  end

end
