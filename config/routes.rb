Rails.application.routes.draw do
  devise_for :users
  root to: 'users#landing'
  resources :receipts, only: :show do
    resources :receipt_items, only: [:new, :create]
  end
  resources :trips do
    get '/export', to: 'trips#export', as: :export
  end
end
