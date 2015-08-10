require Adminsite::Engine.root.join('app/models/page')

module Adminsite
  module Page
    module AdminConfig

      class << self

        def attributes_index
          [ :title,
            :url,
            :requires_login,
            :cacheable,
            :page_layout,
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

        def actions_index
          [ :edit,
            :destroy]
        end

        def label_attribute
          :title
        end
      end
    end
  end
end