Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :sessions, only: [:create]
  delete 'sessions', to: 'sessions#destroy'
  resources :products, only: [:index, :show, :create, :update, :destroy]
  resources :sections, only: [:index, :show, :create, :update, :destroy]
  resources :clients, only: [:index, :show, :create, :update, :destroy]
  resources :employees, only: [:index, :show, :create, :update, :destroy]
  resources :product_options, only: [:create, :destroy]
  resources :carousels, only: [:index, :show, :create, :update, :destroy]
  post 'contact_us', to: 'mails#contact_us'
end
