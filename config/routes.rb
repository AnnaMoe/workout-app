Rails.application.routes.draw do
  devise_for :users
  root to: "dashboards#index"

  resources :users do
    resources :exercises
  end

  resources :dashboards, only: [:index] do
    # search is going to return a collection of user names
    collection do
      post :search, to: 'dashboards#search'
    end 
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: [:create]
end
