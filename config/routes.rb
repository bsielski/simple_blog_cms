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
    resources :stylesheets, only: [:index, :show, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
    end
    resources :sites, only: [:edit, :update]
    resources :authors, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
    end
    resources :header_sections, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
    end
    resources :footer_sections, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
    end
    resources :admins, only: [:index, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
      resources :authors, only: [:index]
    end
  end

  get 'admin', to: 'admin_pages#show', page: "home"

  resources :categories, only: [:index] do
    resources :articles, only: [:index]
  end

  resources :articles, only: [:index, :show]

  resources :authors, only: [:index, :show] do
    resources :articles, only: [:index]
  end

  root "articles#index"
end
