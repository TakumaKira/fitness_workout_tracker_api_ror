Rails.application.routes.draw do
  namespace :api do
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/logged_in", to: "sessions#logged_in"

    resources :workouts
  end
end
