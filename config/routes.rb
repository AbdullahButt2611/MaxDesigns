Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'welcomes#index'

  get '/welcomes', to: 'welcomes#index'

  get '/about', to: 'welcomes#about'

  get '/profile', to: 'welcomes#profile', as: 'profile'

  get '/contacts', to: 'contacts#new', as: 'contacts'

  get '/vendors', to: 'vendors#index', as: 'vendors'

  devise_scope :user do
   get "/registered_users", to: "users/registrations#registered_users"
   patch '/simple_user_update', to: 'users/registrations#simple_user_update', as: 'simple_user_update'
   patch '/update_activity_status', to: 'users/registrations#update_activity_status', as: 'update_activity_status'
  end

  

  resources :contacts
end
