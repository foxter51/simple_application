Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :likes, only: %i[create destroy]
    end
  end
  resources :users
end
