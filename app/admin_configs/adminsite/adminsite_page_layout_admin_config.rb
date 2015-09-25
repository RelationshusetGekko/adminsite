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

    def attributes_search
      attributes_index
    end

    def label_attribute
      :title
    end

  end
end