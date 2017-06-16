Rails.application.routes.draw do
  
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#  get "/pages/:page" => "pages#show"
#  resources :categories

  resources :categories do
    resources :articles
  end

  root "articles#index", category: 1
end
