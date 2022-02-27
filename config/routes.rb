Rails.application.routes.draw do
  resources :todos do
    patch :change_status, on: :member
  end

  root "todos#index"
end
