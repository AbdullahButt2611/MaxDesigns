
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'welcomes#index'

  get '/welcomes', to: 'welcomes#index'

  get '/about', to: 'welcomes#about'

  get '/profile', to: 'welcomes#profile', as: 'profile'

  get '/unprocessable_identity', to: 'welcomes#error', as: 'error'

  get '/project_image_index', to: 'projects#project_image_handler_index', as: 'project_image_handler_index'

  get '/edit_project_image/:id', to: 'projects#edit_projects_image', as: 'edit_projects_image'
  
  patch '/change_project_image/:id', to: 'projects#put_projects_image', as: 'put_projects_image'

  
  get '/dashboard', to: 'dashboards#index', as: 'dashboard'

  get '/search_item_type', to: 'order_details#search_item_type', as: 'search_item_type'
  
  get '/amounts', to: 'amount_receiveds#user_amount', as: 'amounts_page'
  
  get '/transactions', to: 'transactions#user_based_transactions', as: 'transactions_page'
  
  get '/offered_items', to: 'vendors#item_details_page', as: 'offered_items_page'
  
  get "/project_status_index", to: "projects#project_status_index", as: 'project_status_index'
  patch '/complete_changer/:id', to: 'projects#complete_changer', as: 'complete_changer'
  
  get "/completed_project_reports", to: "projects#project_reports", as: 'project_reports'

  

  get '/see_all_payments', to: 'projects#see_all_payments', as: 'see_all_payments'
  
  get '/see_all_details', to: 'projects#see_all_details', as: 'see_all_details'
  
  get '/see_all_order_details', to: 'projects#see_all_order_details', as: 'see_all_order_details'
  
  get '/:id/history', to: 'vendor_historys#index', as: 'vendor_history'
  
  
  
  # Routes For Contacts
  get '/contacts', to: 'contacts#new', as: 'contacts'
  get '/contacts/all', to: 'contacts#index', as: 'contacts_display'
  resources :contacts, only: [:create]
  



  devise_scope :user do
   get "/registered_users", to: "users/registrations#registered_users"
   patch '/simple_user_update', to: 'users/registrations#simple_user_update', as: 'simple_user_update'
   patch '/update_activity_status', to: 'users/registrations#update_activity_status', as: 'update_activity_status'
   get '/users_pay_section', to: 'users/registrations#user_pays_section', as: 'user_pays_section'
   get "/edit_user_pay/:id/edit", to: "users/registrations#edit_user_pay", as: 'edit_user_pay'
   patch '/update_user_pay/:id', to: 'users/registrations#update_user_pay', as: 'update_user_pay'
   get "/salary_slips", to: "users/registrations#salary_slips", as: 'salary_slips'
  end

  resources :vendors do
    resources :items
  end

  resources :projects do
    resources :project_details

    resources :orders do
      resources :transactions
      resource :order_details
    end

    resources :amount_receiveds, except: [:index, :edit, :update, :destroy]
    
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


  namespace :api do
    namespace :v1 do
      get "/identify", to: 'live_checkers#identify'
    end
  end


end
