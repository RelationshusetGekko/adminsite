module Test
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
      [ :title,
        :url,
        :requires_login,
        :cacheable,
        :page_layout
      ]
    end

    def self.attributes_show
      attributes_edit + [:updated_at]
    end

    def self.actions_index
      [ :show,
        :edit,
        :destroy]
    end
  end
end