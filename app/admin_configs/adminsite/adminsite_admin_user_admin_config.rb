module Adminsite
  class AdminsiteAdminUserAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ :name,
        :email,
        :updated_at
      ]
    end

    def attributes_edit
      [ :name,
        :email,
        :password,
        :password_confirmation
      ]
    end

    def attributes_show
      [ :name,
        :email,
        :updated_at
      ]
    end

    def actions_index
      [ :new ]
    end

    def default_member_actions
      [ :edit,
        :destroy]
    end

    def label_attribute
      :email
    end
  end
end