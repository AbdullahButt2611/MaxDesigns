# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    # user.is_a?(ActiveAdmin) v  # To check if a user is a simple user or an admin user
    
    if not user.no_role?
      if user.hr?

        can :simple_user_update, User
        can :update_activity_status, User
        can :manage, User
        can :read, User
        can :profile, User  
        can :read, Order
        cannot :manage, Order
        cannot :manage, Item
        cannot :read, Item
        can :read, Dashboard
        cannot :read, AmountReceived
        cannot :manage, AmountReceived
        cannot :read, ProjectDetail
        cannot :manage, ProjectDetail
        cannot :read, OrderDetail
        cannot :manage, OrderDetail
        cannot :read, Transaction
        cannot :manage, Transaction
        cannot :read, VendorHistory
        cannot :manage, VendorHistory
        can :read, Vendor
        cannot :manage, Vendor
        can :read, Contact
        can :update_user_pay, User               
        can :item_details_page, Vendor              
        can :edit_user_pay, User                 
        can :user_pays_section, User             
        cannot :project_status_index, Project       
        cannot :complete_changer, Project           
        cannot :see_all_payments, Project           
        cannot :see_all_details, Project            
        cannot :see_all_order_details, Project      


        

      elsif user.vendor?
        can :manage, User
        can :profile, User
        cannot :read, Project
        cannot :manage, Project
        cannot :read, Order
        cannot :manage, Order
        can :read, Item
        can :manage, Item
        can :read, Dashboard
        cannot :read, AmountReceived
        cannot :manage, AmountReceived
        cannot :read, ProjectDetail
        cannot :manage, ProjectDetail
        cannot :read, OrderDetail
        cannot :manage, OrderDetail
        cannot :read, Transaction
        cannot :manage, Transaction
        can :read, VendorHistory
        can :manage, VendorHistory
        can :read, Vendor
        can :manage, Vendor
        cannot :read, Contact
        cannot :simple_user_update, User            
        cannot :update_activity_status, User        
        can :item_details_page, Vendor              
        cannot :update_user_pay, User               
        cannot :edit_user_pay, User                 
        cannot :user_pays_section, User             
        cannot :project_status_index, Project       
        cannot :complete_changer, Project           
        cannot :see_all_payments, Project           
        cannot :see_all_details, Project            
        cannot :see_all_order_details, Project      

        


      elsif user.developer?
        can :item_details_page, Vendor
        can :user_pays_section, User

        can :read, :all
        can :manage, :all
        can :profile, User

      elsif user.customer?
        cannot :manage, User
        can :profile, User                          #Use it as reference
        can :read, Project
        cannot :read, Order
        can :read, Item
        cannot :manage, Item
        can :read, Dashboard
        cannot :read, AmountReceived
        cannot :manage, AmountReceived
        cannot :read, ProjectDetail
        cannot :manage, ProjectDetail
        cannot :read, OrderDetail
        cannot :manage, OrderDetail
        cannot :read, Transaction
        cannot :manage, Transaction
        cannot :read, VendorHistory
        cannot :manage, VendorHistory
        can :read, Vendor
        cannot :manage, Vendor
        cannot :read, Contact
        cannot :simple_user_update, User            #Use it as reference
        cannot :update_activity_status, User        #Use it as reference
        can :item_details_page, Vendor              #Use it as reference
        cannot :update_user_pay, User               #Use it as reference
        cannot :edit_user_pay, User                 #Use it as reference
        cannot :user_pays_section, User             #Use it as reference
        cannot :project_status_index, Project       #Use it as reference
        cannot :complete_changer, Project           #Use it as reference
        cannot :see_all_payments, Project           #Use it as reference
        cannot :see_all_details, Project            #Use it as reference
        cannot :see_all_order_details, Project      #Use it as reference
        

      elsif user.architect?

        # can :profile, User
        # can :manage, ProjectDetail
        # can :read, ProjectDetail
        # can :read, Project
        # can :read, Order
        cannot :manage, User
        can :profile, User

      elsif user.management?

        can :item_details_page, Vendor
        can :user_pays_section, User
        can :read, :all
        can :manage, :all
        can :profile, User
        cannot :read, AmountReceived
        cannot :manage, AmountReceived
        can :user_pays_section, User
        cannot :edit_user_pay, User
        cannot :update_user_pay, User
        

      elsif user.accountant?
        cannot :manage, User
        can :profile, User
        can :read, Project
        can :read, Order
        can :manage, Order
        can :read, OrderDetail
        can :manage, OrderDetail
        can :read, Item
        cannot :manage, Item
        can :read, Dashboard
        can :read, AmountReceived
        can :manage, AmountReceived
        can :read, ProjectDetail
        can :manage, ProjectDetail
        can :read, Transaction
        can :manage, Transaction
        cannot :read, VendorHistory
        cannot :manage, VendorHistory
        can :read, Vendor
        cannot :manage, Vendor
        cannot :read, Contact
        cannot :simple_user_update, User            
        cannot :update_activity_status, User        
        can :item_details_page, Vendor              
        cannot :update_user_pay, User               
        cannot :edit_user_pay, User                 
        cannot :user_pays_section, User             
        cannot :project_status_index, Project       
        cannot :complete_changer, Project           
        can :see_all_payments, Project           
        can :see_all_details, Project            
        can :see_all_order_details, Project      
      end
    else
      can :read, Dashboard
      cannot :read, :all
      cannot :manage, :all
      can :profile, User
    end
  end
end
