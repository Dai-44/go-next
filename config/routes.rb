Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "searches#new"
  resources :searches, only: %i[new create] do
    get :result, on: :collection
  end

  resources :users, only: %i[new create]
  get 'login', to: 'usersessions#new'
  post 'login', to: 'usersessions#create'
  delete 'logout', to: 'usersessions#destroy'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :drive_records, only: %i[index show create]
  resources :bookmarks, only: %i[create destroy]
  resources :destinations, only: %i[show] do
    get "bookmarks", on: :collection
  end

  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
