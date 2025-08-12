Rails.application.routes.draw do
  devise_for :users

  resources :journeys, only: [:new, :create]

  resources :characters, only: [:show, :new, :create, :update, :destroy]

  resources :quests, only: [] do
    collection do
      get :dashboard
    end
  end

  resources :characters, only: [:index, :new, :create, :update, :destroy]

  resource :store, path: "thewanderingsatchel", only: [:show] do
    collection do
      get :list_items
    end
    member do
      post :purchase_items
    end
  end

  resources :items, only: [:show]


  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
