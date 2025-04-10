Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :products
    resources :activity_logs, only: [:index, :show]
  end

  resources :products

  resources :cart_items do
    member do
      patch :increase
      patch :decrease
    end
  end

  resources :orders

  root to: 'products#index'

  resources :payments do
    collection do
      get :success
      get :cancel
    end
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
