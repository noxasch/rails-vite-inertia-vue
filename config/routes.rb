Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations passwords], controllers: { sessions: 'users/sessions'}
  
  get 'inertia-example', to: 'inertia_example#index'
  # resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # root 'inertia_example#index'
  root 'pages#home'
  resource :users, only: %i[show] do
    get :signup, to: 'users#new'
    post :signup, to: 'users#create'
  end
end
