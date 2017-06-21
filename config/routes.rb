Rails.application.routes.draw do
  
  devise_for :admins
  
  namespace :admin do
    resources :categories, only: [:index, :new, :edit] do
      resources :articles
    end
  end
  
  resources :categories, only: [:index] do
    resources :articles
  end

  root "articles#index", category: 1
end
