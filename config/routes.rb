Rails.application.routes.draw do
  # get 'submissions/index'
  # get 'submissions/show'
  # get 'submissions/new'
  # get 'submissions/create'
  # get 'submissions/edit'
  # get 'submissions/update'
  # get 'submissions/destroy'
  # get 'users/index'
  # get 'users/show'
  # get 'users/new'
  # get 'users/create'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # get 'households/show'
  # get 'households/new'
  # get 'households/create'
  # get 'households/edit'
  # get 'households/update'
  # get 'households/destroy'
  # get 'tasks/index'
  # get 'tasks/show'
  # get 'tasks/new'
  # get 'tasks/create'
  # get 'tasks/edit'
  # get 'tasks/update'
  # get 'tasks/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :tasks, only: [:index, :new, :create, :edit, :update]

  resources :household, only: [:show, :new, :create]

  resources :user, only: [:index, :show]

  resources :submissions, only: [:new, :create]





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
