Rails.application.routes.draw do
  resources :students
  
  # Define your root path route ("/")
  root "students#index" # or "students#new" if we want the form to be the homepage

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
