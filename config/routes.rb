Rails.application.routes.draw do
  get 'receipt_items/new'
  get 'receipt_items/create'
  get 'receipt_items/edit'
  get 'receipt_items/update'
  get 'receipt_items/destroy'
  devise_for :users
  root to: 'pages#landing'
  #temporary testing route -- delete later
  get '/mobile', to: 'pages#mobile'
  get '/desktop', to: 'pages#desktop'

  # dashboard for employer
  namespace :employer do
    get '/dashboard', to: 'users#dashboard', as: :dashboard
    get '/show', to: 'users#show', as: :show
    get '/employees', to: 'users#index', as: :index
  end

  # dashboard for employee
  namespace :employee do
    get '/dashboard', to: 'users#dashboard', as: :dashboard
    get '/show', to: 'users#show', as: :show
  end

  resources :receipts, only: :show do
    resources :receipt_items, only: [:new, :create]
  end
  resources :trips do
    get '/export', to: 'trips#export', as: :export
    resources :receipts, only: [:new, :update, :create]
  end
  resources :receipts, only: [:edit, :destroy] do
    resources :receipt_items, except: [:index, :show, :destroy]
  end
  resources :receipt_items, only: [:destroy]
  get '/users/:id', to: 'users#show', as: :user_show
end
