Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :households, only: [:show, :new, :create, :edit, :update, :show] do
    member do
      post :timetable
    end
  end

  resources :users, only: [:index, :show]

  resources :submissions, only: [:new, :create, :edit, :update,]






  # Routes for users
  # resources :users, only: [:index, :show, :edit, :update] do
  #   resources :submissions, only: [:index, :show, :create, :edit, :update, :destroy]
  # end

  # # Routes for households
  # resources :households, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  #   resources :tasks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # end

  # # Direct routes for tasks if needed outside of households
  # resources :tasks, only: [:destroy]

  # # Direct routes for submissions if needed outside of users
  # resources :submissions, only: [:destroy]
end
