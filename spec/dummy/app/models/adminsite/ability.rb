module Adminsite
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= AdminUser.new
      user.admin_user_roles.each do |role|
        case role.name.to_sym
        when :admin
          can :manage, :all
        when :editor
          can :read, Adminsite::Page
          can :read, Adminsite::PageLayout
          can :read, Adminsite::FileAsset
          can :read, Adminsite::AdminUser
          can :read, Adminsite::AdminUserRole
        when :customer
          # can :read, Adminsite::Page
          # can :read, Adminsite::PageLayout
          # can :read, Adminsite::FileAsset
        end
        can :manage, Adminsite::AdminUserSessionsController
      end
    end
  end
end
