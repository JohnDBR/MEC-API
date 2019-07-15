Rails.application.routes.draw do
  resources :products
  resources :sections
  resources :clients
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  
end
