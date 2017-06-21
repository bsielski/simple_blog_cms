Rails.application.routes.draw do
  
  namespace :admin do
    get 'articles/index'
  end

  namespace :admin do
    get 'articles/new'
  end

  namespace :admin do
    get 'articles/edit'
  end

  namespace :admin do
    get 'articles/show'
  end

  namespace :admin do
    get 'articles/delete'
  end

  devise_for :admins
  
  namespace :admin do
    resources :categories, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
      member do
        get 'delete'
      end
      resources :articles
    end
  end
  
  resources :categories, only: [:index] do
    resources :articles
  end

  root "articles#index", category: 1
end
