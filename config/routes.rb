Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :products, only: [:index, :show, :create, :update, :destroy]
  resources :sections, only: [:index, :show, :create, :update, :destroy]
  resources :clients, only: [:index, :show, :create, :update, :destroy]
  resources :employees, only: [:index, :show, :create, :update, :destroy]
end
