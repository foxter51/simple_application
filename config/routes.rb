Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/new'
  # get 'posts/create'
  # get 'posts/update'
  # get 'posts/destroy'
  # get 'posts/show'
  # get 'posts/edit'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'welcome/index'
  root 'welcome#index'
  resources :posts
end
