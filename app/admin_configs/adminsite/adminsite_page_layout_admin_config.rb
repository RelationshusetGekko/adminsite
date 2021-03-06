module Adminsite
  class AdminsitePageLayoutAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ :id,
        :title,
        :updated_at
      ]
    end

    def attributes_edit(resource = nil)
      [ :title,
        :body => {:input_html => {:class => 'code html'}}
      ]
    end

    def default_member_actions(resource = nil)
      [ :edit,
        :destroy]
    end

    def attributes_search
      attributes_index
    end

    def label_attribute(resource = nil)
      :title
    end

  end
end