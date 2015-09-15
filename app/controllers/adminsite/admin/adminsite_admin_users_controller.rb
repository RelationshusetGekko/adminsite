module Adminsite
  class Admin::AdminsiteAdminUsersController < Adminsite::Admin::ResourcesController

    protected

    def filter_scopes
      []
    end

    def self.resource_class
      Adminsite::AdminUser
    end

    def order_params
      'email ASC'
    end

    def resource_admin_config
      # Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
      # -> Result: "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" || Adminsite::AdminConfig::Base
      super
    end

    # self.register_routes

  end
end