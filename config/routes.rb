Rails.application.routes.draw do
  
  devise_for :admins
  
  namespace :admin do
    resources :categories, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
      resources :articles
    end
    resources :articles do
      member do
        get 'delete'
      end
    end
  end
  
  resources :categories, only: [:index] do
    resources :articles
  end

  root "articles#index"
end
