Rails.application.routes.draw do
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
  resources :receipts, only: [:show, :edit, :destroy] do
    resources :receipt_items, except: [:index, :show, :destroy, :edit]
  end
  resources :receipt_items, only: [:destroy, :edit]
  get '/users/:id', to: 'users#show', as: :user_show

  #pdf generating routes
  get '/trips/:id/report', to: 'trips#report', as: :report
end
