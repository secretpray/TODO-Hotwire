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

  get "account", to: "users#edit"
  put "account", to: "users#update"
  delete "account", to: "users#destroy"

  resources :confirmations, only: %i[create edit new], param: :confirmation_token
  resources :passwords, only: %i[create edit new update], param: :password_reset_token

  resources :active_sessions, only: :destroy do
    collection do
      delete "destroy_all"
    end
  end

  root "static_pages#home"
end
