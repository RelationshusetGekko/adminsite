module Adminsite
  class Admin::AdminsiteAdminUsersController < Adminsite::Admin::ResourcesController

    protected

    def resource_class
      Adminsite::AdminUser
    end

    def order_params
      'email ASC'
    end

  end
end