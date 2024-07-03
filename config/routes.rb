Rails.application.routes.draw do
  # devise_for :users, skip: %i[sessions registrations passwords]
  get 'inertia-example', to: 'inertia_example#index'
  # resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resource :users, only: %i[] do
    get :signup, to: 'users#new'
    post :signup, to: 'users#create'
  end
end
