Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :skills do
    resources :bookings, only: [:new, :show, :create] do
      resources :reviews
    end
  end
end
