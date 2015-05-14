Rails.application.routes.draw do
  root 'home#index'
  resources :donate, only: [:new, :create, :show]
  resources :hospital, only: [:index, :new, :create, :show, :update]
  get 'hospital/:id/blood-status', to: 'hospital#edit', as: :hospital_blood_status

  get '/search', to: 'home#search'
  match '/admin' => DelayedJobWeb, :anchor => false, via: [:get, :post]
end
