module Adminsite
  class Admin::AdminsiteAdminUsersController < Adminsite::Admin::ResourcesController

    def update
      remove_empty_pw
      super
    end

    protected

    def remove_empty_pw
      [:password, :password_confirmation].each do |p|
        params[:adminsite_admin_user][p] = nil if params[:adminsite_admin_user][p].blank?
      end
    end

    def self.resource_class
      Adminsite::AdminUser
    end

    def order_params
      'email ASC'
    end

    def resource_admin_config
      # Adminsite::Admin::ResourcesController.resource_admin_config
      super
    end

  end
end