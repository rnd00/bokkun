Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing'
  #temporary testing route -- delete later
  get '/mobile', to: 'pages#mobile'
  get '/desktop', to: 'pages#desktop'

  # dashboard for employer
  namespace :employer do
    get '/dashboard', to: 'users#dashboard', as: :dashboard
  end

  # dashboard for employee
  namespace :employee do
    get '/dashboard', to: 'users#dashboard', as: :dashboard
  end

  resources :receipts, only: :show do
    resources :receipt_items, only: [:new, :create]
  end
  resources :trips do
    get '/export', to: 'trips#export', as: :export
    resources :receipts, only: [:new, :create]
  end
  resources :receipts, except: [:new, :create, :index, :show] do
    resources :receipt_items, except: [:index, :show]
  end
  get '/users/:id', to: 'users#show', as: :user_show
end
