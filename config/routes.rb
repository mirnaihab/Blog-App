Rails.application.routes.draw do
  # mount_devise_token_auth_for "User", at: "auth"
  mount Rswag::Api::Engine => "/api-docs"
  mount Rswag::Ui::Engine => "/api-docs"

  # mount_devise_token_auth_for "User", at: "auth", controllers: {
  #   registrations: "users/registrations"
  # }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "/swagger.yaml", to: proc { [ 200, { "Content-Type" => "application/x-yaml" }, [ File.read(Rails.root.join("swagger", "v1", "swagger.yaml")) ] ] }

  get "up" => "rails/health#show", as: :rails_health_check

  # Custom authentication route
  post "/auth/login", to: "authentication#authenticate"

  # Devise routes for user authentication
  devise_for :users, controllers: { registrations: "users/registrations" }
  # devise_for :users, controllers: {
  #   sessions: "users/sessions",
  #   registrations: "users/registrations"
  # }
  # resources :posts
  # resources :posts do
  #   resources :comments, only: [ :index, :show, :create, :update, :destroy ]
  # end
  resources :posts do
    member do
      patch :tags, to: "posts#update_Post_tags"
    end
    resources :comments, only: [ :index, :show, :create, :update, :destroy ]
  end
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
