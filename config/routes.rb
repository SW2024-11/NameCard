Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get 'top/main'
  post 'top/login'
  
  root 'top#main'
  
  resources :users
  resources :cards
end
