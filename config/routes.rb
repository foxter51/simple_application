Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
end
