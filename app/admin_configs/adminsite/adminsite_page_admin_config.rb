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

    def attributes_edit(resource = nil)
      [ :title,
        :url,
        :requires_login,
        :cacheable,
        :page_layout,
        :body => {:input_html => {:class => 'code html'}}
      ]
    end

    def attributes_show(resource = nil)
      attributes_edit
    end

    def attributes_search
      attributes_index
    end

    def default_member_actions(resource = nil)
      [ :edit, :destroy]
    end

    def label_attribute(resource = nil)
      :title
    end

    def scopes
       [:all, :cacheable, :requires_login ]
    end

  end
end