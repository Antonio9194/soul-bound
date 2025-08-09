Rails.application.routes.draw do
  devise_for :users

  resources :journeys, only: [:new, :create]

  resources :quests, only: [] do
    collection do
      get :dashboard
    end
  end

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end