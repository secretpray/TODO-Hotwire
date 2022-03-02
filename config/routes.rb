Rails.application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  resources :sessions, only: [:index, :show, :destroy]
  resource :email, only: [:edit, :update]
  resource :email_verification, only: [:edit, :create]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :edit, :create, :update]
  resource :registration, only: :destroy
  resource :sudo, only: [:new, :create]
  root 'home#index'

  resources :todos do
    patch :change_status, on: :member
  end
end
