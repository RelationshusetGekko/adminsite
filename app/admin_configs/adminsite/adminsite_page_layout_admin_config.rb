module Adminsite
  class AdminsitePageLayoutAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ :id,
        :title,
        :updated_at
      ]
    end

    def attributes_edit
      [ :title,
        :body
      ]
    end

    def default_member_actions
      [ :edit,
        :destroy]
    end

    def label_attribute
      :title
    end

  end
end