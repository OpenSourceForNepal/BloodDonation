Rails.application.routes.draw do
  root 'home#index'

  resources :donate, only: [:new, :create, :show]

  match '/admin' => DelayedJobWeb, :anchor => false, via: [:get, :post]
end
