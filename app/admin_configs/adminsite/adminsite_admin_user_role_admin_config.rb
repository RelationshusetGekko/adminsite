module Adminsite
  class AdminsiteAdminUserRoleAdminConfig < Adminsite::AdminConfig::Base


    def label_attribute(resource = nil)
      :name
    end

  end
end