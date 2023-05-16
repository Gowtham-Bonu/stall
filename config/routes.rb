Rails.application.routes.draw do
  root "products#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :products do
    resources :orders, shallow: true
  end
end
