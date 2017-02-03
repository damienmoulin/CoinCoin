Rails.application.routes.draw do
  devise_for :users

  get 'articles/index'

  get 'profile', to: 'profile#index', as: 'profile'

  resources :comments do
    resources :articles
  end

  resources :articles do
    resources :categories
  end
  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
