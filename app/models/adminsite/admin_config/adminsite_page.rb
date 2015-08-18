module Adminsite
  module AdminConfig
    class AdminsitePage < Adminsite::AdminConfig::Base

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