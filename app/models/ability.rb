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

        can :simple_user_update, User, User.where(user_roles: :no_role)
        can :update_activity_status, User, User.where(user_roles: :no_role)
        can :manage, User
        can :read, User
        can :read, Contact
        can :read, Item
        cannot :manage, Order
        cannot :manage, Item
        can :read, Order
        cannot :manage, Project
        cannot :manage, ProjectDetail
        can :read, ProjectDetail
        can :profile, User

      elsif user.vendor?

        cannot :simple_user_update, User
        cannot :update_activity_status, User
        can :manage, Item
        can :read, Item
        can :manage, Vendor
        can :read, Vendor
        can :read, Project
        cannot :manage, Project
        can :profile, User


      elsif user.developer?

        can :read, :all
        can :manage, :all
        can :profile, User

      elsif user.customer?
        cannot :manage, :all
        can :profile, User
        can :read, Project
        cannot :read, Order
        cannot :manage, Order
        can :read, Item
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
        cannot :read, Contact
        cannot :simple_user_update, User
        cannot :update_activity_status, User


      elsif user.architect?

        can :profile, User
        can :manage, ProjectDetail
        can :read, ProjectDetail
        can :read, Project
        can :read, Order

      elsif user.management?

        can :profile, User
        can :manage, User
        can :manage, Project
        can :manage, Vendor
        can :read, all
        

      elsif user.accountant?

        can :profile, User

      end
    else
      can :read, Dashboard
      cannot :read, :all
      cannot :manage, :all
      can :profile, User
    end
  end
end
