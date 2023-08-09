Rails.application.routes.draw do
  get 'search', to: 'search#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[new create destroy] do
      resources :likes, only: %i[create destroy]
    end
  end
  resources :users do
    resources :subscriptions, only: %i[create destroy]
  end
  resources :feed
end
