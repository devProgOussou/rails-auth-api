Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/signup'
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"

  resources :todos
end
