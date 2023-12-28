Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "searches#index"
  resources :searches, only: %i[new create] do
    get :result, on: :collection
  end

  resources :users, only: %i[new create]
  get 'login', to: 'usersessions#new'
  post 'login', to: 'usersessions#create'
  delete 'logout', to: 'usersessions#destroy'

  post "oauth/callback" => "oauths#callback" # これの必要性がいまいちピンと来てないので、後ほど調べてみて不要なら消す。今は参考記事に倣って記述してある。
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
end
