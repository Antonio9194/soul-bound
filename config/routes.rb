Rails.application.routes.draw do
  devise_for :users

  resources :journeys, only: [:new, :create]

  resources :characters, only: [:show, :new, :create, :update, :destroy]

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
