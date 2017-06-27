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
    resources :stylesheets, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
        get 'activate'
      end
    end
    resources :sites, only: [:edit, :update]
  end

  get 'admin', to: 'admin_pages#show', page: "home"

  resources :categories, only: [:index] do
    resources :articles, only: [:index]
  end
  
  resources :articles, only: [:index, :show]
  
  root "articles#index"
end
