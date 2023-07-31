Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :likes, only: %i[create destroy]
    end
  end
end
