Rails.application.routes.draw do
  get 'static_pages/home'
  resources :todos do
    patch :change_status, on: :member
  end

  post "sign_up", to: "users#create"
  get "sign_up", to: "users#new"

  root "static_pages#home"
end
