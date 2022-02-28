Rails.application.routes.draw do
  get 'static_pages/home'
  resources :todos do
    patch :change_status, on: :member
  end

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

  root "static_pages#home"
end
