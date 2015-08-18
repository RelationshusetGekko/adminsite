module Adminsite
  module AdminConfig
    class AdminsitePageLayout < Adminsite::AdminConfig::Base

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