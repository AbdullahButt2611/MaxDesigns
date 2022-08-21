Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcomes#index'

  get '/welcomes', to: 'welcomes#index'

  get '/about', to: 'welcomes#about'

  get '/profile', to: 'welcomes#profile', as: 'profile'

  get '/contacts', to: 'contacts#new', as: 'contacts'

  get '/vendors', to: 'vendors#index', as: 'vendors'

  resources :contacts
end
