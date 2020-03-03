Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing'
  resources :receipts, only: :show
end
