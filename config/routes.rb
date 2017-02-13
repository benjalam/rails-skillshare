Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :reviews
  end
  resources :skills do
    resources :bookings, only: [:new, :show, :create]
  end
end
