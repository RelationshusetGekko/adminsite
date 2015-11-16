module Adminsite
  class AdminsiteAdminUserAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ :name,
        :email,
        :updated_at
      ]
    end

    def attributes_edit(resource = nil)
      [ :name,
        :email,
        :password,
        :password_confirmation
      ]
    end

    def attributes_show(resource = nil)
      [ :name,
        :email,
        :updated_at
      ]
    end

    def attributes_search
      attributes_index
    end

    def actions_index
      [ :new ]
    end

    def default_member_actions(resource = nil)
      [ :edit,
        :destroy]
    end

    def label_attribute(resource = nil)
      :email
    end
  end
end