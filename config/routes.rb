Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get 'top/top_page'
  
  root 'top#top_page'
  
  resources :users
  resources :cards
end
