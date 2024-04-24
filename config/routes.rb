Rails.application.routes.draw do
  devise_for :admins
  namespace :api do
    namespace :v1 do

      post "api_key", to: "apikey#create"
      get "list_api_key", to: "apikey#index"

      devise_scope :admin do
        post "sign_up", to: "registrations#create"
        post "reset_pasword", to: "registrations#create_password_reset_token"
        post "update_password", to: "registrations#update_password"
        post "sing_in", to: "sessions#create"
        post "log_out", to: "sessions#destroy"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
