module Adminsite
  module AdminConfig
    class AdminsiteFileAsset < Adminsite::AdminConfig::Base

      def attributes_index
        [ 'attachment.url',
          'attachment_file_name',
          'attachment_file_size',
          'updated_at',
        ]
      end

      def actions_index
        [ ]
      end

      def default_member_actions
        [ :destroy ]
      end

      def label_attribute
        :attachment_file_name
      end
    end
  end
end