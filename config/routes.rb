Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  get 'top/main'
  get 'users/new', to: 'users#new_form'
  get 'top/login', to: 'top#login_form'
  post 'top/login'
  get 'top/logout'
  
  #root 'top#main'
  root 'cards#index'
  
  resources :users
  resources :cards
  
  get 'get_image/:id', to: 'images#get_image'
  get 'cards', to: 'cards#index', as: 'card_with_view_type'
end
