Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments do
      resources :likes, only: %i[create destroy]
    end
  end
  resources :users do
    resources :subscriptions
  end
end
