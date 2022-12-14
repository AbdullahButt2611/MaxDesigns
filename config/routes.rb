
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

  
  
  
  
  get '/amounts', to: 'amount_receiveds#user_amount', as: 'amounts_page'
  
  get '/transactions', to: 'transactions#user_based_transactions', as: 'transactions_page'
  
  get '/offered_items', to: 'vendors#item_details_page', as: 'offered_items_page'
  
  
  get '/:id/history', to: 'vendor_historys#index', as: 'vendor_history'
  
  
  
  
  # Route For Dashboard
  get '/dashboard', to: 'dashboards#index', as: 'dashboard'
  
  
  
  
  # Additional Route for Order Details
  get '/search_item_type', to: 'order_details#search_item_type', as: 'search_item_type'
  
  
  
  
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
    resources :items, except: :show
  end
  
  
  
  
  
  
  
  
  # Routes For Projects
  get '/project_image_index', to: 'projects#project_image_handler_index', as: 'project_image_handler_index'
  get '/edit_project_image/:id', to: 'projects#edit_projects_image', as: 'edit_projects_image'
  patch '/change_project_image/:id', to: 'projects#put_projects_image', as: 'put_projects_image'
  get "/project_status_index", to: "projects#project_status_index", as: 'project_status_index'
  patch '/complete_changer/:id', to: 'projects#complete_changer', as: 'complete_changer'
  get "/completed_project_reports", to: "projects#project_reports", as: 'project_reports'
  get '/see_all_payments', to: 'projects#see_all_payments', as: 'see_all_payments'
  get '/see_all_details', to: 'projects#see_all_details', as: 'see_all_details'
  get '/see_all_order_details', to: 'projects#see_all_order_details', as: 'see_all_order_details'
  resources :projects do
    resources :project_details, except: [:index, :show]

    resources :orders, only: [:create, :destroy, :show] do
      resources :transactions
      resource :order_details, except: [:index, :show, :edit, :update]
    end

    resources :amount_receiveds, except: [:index, :edit, :update, :destroy]
    
  end
  



  # Additional Routes
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





  # Route Created To Check API
  namespace :api do
    namespace :v1 do
      get "/identify", to: 'live_checkers#identify'
    end
  end


end
