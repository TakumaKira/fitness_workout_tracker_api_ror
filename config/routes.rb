Rails.application.routes.draw do
  namespace :api do
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/logged_in", to: "sessions#logged_in"

    resources :exercises
    resources :workouts do
      resources :workout_exercises do
        collection do
          post :batch_create
        end
      end
    end
  end
end
