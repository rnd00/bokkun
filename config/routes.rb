Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing'
  #temporary testing route -- delete later
  get '/home', to: 'pages#home'
  get '/mobile', to: 'pages#mobile'

  get '/dashboard', to: 'users#dashboard', as: :dashboard
  resources :receipts, only: :show do
    resources :receipt_items, only: [:new, :create]
  end
  resources :trips do
    get '/export', to: 'trips#export', as: :export
    resources :receipts, only: [:new, :create]
  end
  resources :receipts, except: [:new, :create, :index]
  get '/users/:id', to: 'users#show', as: :user_show
end
