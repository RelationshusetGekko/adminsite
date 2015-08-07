require Adminsite::Engine.root.join('app/models/page')

class Page
  module AdminConfig

    def self.attributes_index
      [ :title,
        :url,
        :requires_login,
        :cacheable,
        :page_layout,
        :updated_at
      ]
    end

    def self.attributes_edit
      attributes_index
    end

    def self.attributes_show
      attributes_edit
    end

    def self.actions_index
      [ :edit,
        :destroy]
    end
  end
end