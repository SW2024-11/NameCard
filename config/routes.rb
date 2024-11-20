Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get 'top/top_page'
  resources :users, only: [:new]
  
  root 'top#top_page'
end
