require Adminsite::Engine.root.join('app/models/page_layout')

module Adminsite
  module PageLayout
    module AdminConfig

      class << self

        def attributes_index
          [ :title,
            :updated_at
          ]
        end

        def attributes_edit
          [ :title,
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