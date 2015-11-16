module Adminsite
  class Admin::AdminsiteAdminUsersController < Adminsite::Admin::ResourcesController

    protected

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