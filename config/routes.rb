Rails.application.routes.draw do
  root to: 'urls#index'

  get 'r', to: 'redirects#index'

  get 'stats', to: 'urls#show'
  resources :urls, only: :create
end
