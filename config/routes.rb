Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      post "/signup", to: "users#create", defaults: {format: "json"}
      resources :users, only: [:show, :update]
      post "/login", to: "authentications#login", defaults: {format: "json"}
      delete "/logout", to: "authentications#logout", defaults: {format: "json"}
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
