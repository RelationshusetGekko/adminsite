module Adminsite
  class AdminsitePageAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ :title,
        :url,
        :requires_login,
        :cacheable,
        :page_layout_id,
        :updated_at
      ]
    end

    def attributes_edit
      [ :title,
        :url,
        :requires_login,
        :cacheable,
        :page_layout,
        :body
      ]
    end

    def attributes_show
      attributes_edit
    end

    def attributes_search
      attributes_index
    end

    def default_member_actions
      [ :edit,
        :destroy]
    end

    def label_attribute
      :title
    end

    def scopes
       [:all, :cacheable, :requires_login ]
    end

  end
end