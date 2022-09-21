
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'welcomes#index'

  get '/welcomes', to: 'welcomes#index'

  get '/about', to: 'welcomes#about'

  get '/profile', to: 'welcomes#profile', as: 'profile'

  get '/contacts', to: 'contacts#new', as: 'contacts'

  get '/dashboard', to: 'dashboards#index', as: 'dashboard'

  get '/search_item_type', to: 'order_details#search_item_type', as: 'search_item_type'
  
  get '/amounts', to: 'amount_receiveds#user_amount', as: 'amounts_page'

  devise_scope :user do
   get "/registered_users", to: "users/registrations#registered_users"
   patch '/simple_user_update', to: 'users/registrations#simple_user_update', as: 'simple_user_update'
   patch '/update_activity_status', to: 'users/registrations#update_activity_status', as: 'update_activity_status'
  end

  resources :vendors do
    resources :items
  end

  resources :projects do
    resources :project_details

    resources :orders do
      resource :order_details
    end

    resources :amount_receiveds

  end
  

  module Routes
    module ClassMethods
      
    end
    
    module InstanceMethods
      
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end

  resources :contacts

  namespace :api do
    namespace :v1 do
      get "/identify", to: 'live_checkers#identify'
    end
  end


end
