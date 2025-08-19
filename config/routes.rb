Rails.application.routes.draw do
  devise_for :users

  resources :journeys, only: [:new, :create]

  resources :characters

  resources :quests, only: [:edit, :update] do
    collection do
      get :dashboard
    end
  end

  resources :characters, only: [:index, :new, :create, :update, :destroy]

  resources :inventory_items, only: [:index, :show] do
    member do
      patch :equip
      patch :unequip
    end
  end

  resource :store, path: "thewanderingsatchel", only: [:show] do
    collection do
      get :list_items
    end
    member do
      post :purchase_items
    end
  end

  resources :items, only: [:index, :show]


  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
