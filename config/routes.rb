Rails.application.routes.draw do
  devise_for :users
  root to: 'users#landing'
  resources :receipts, only: :show do
    resources :receipt_items, only: [:new, :create]
  end
  resources :trips do
    get '/export', to: 'trips#export', as: :export
    resources :receipts, only: [:new, :create]
  end
  resources :receipts, except: [:new, :create, :index]
  get '/users/:id', to: 'users#show', as: :user_show

  #test route for partial development -- will be deleted
  get '/home', to: 'pages#home'
end
