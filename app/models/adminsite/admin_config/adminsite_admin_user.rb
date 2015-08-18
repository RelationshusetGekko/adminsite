module Adminsite
  module AdminConfig
    class AdminsiteAdminUser < Adminsite::AdminConfig::Base

      def attributes_index
        [ :name,
          :email,
          :updated_at
        ]
      end

      def attributes_edit
        [ :name,
          :email,
          :password,
          :password_confirmation
        ]
      end

      def attributes_show
        [ :name,
          :email,
          :updated_at
        ]
      end

      def actions_index
        [ :edit,
          :destroy]
      end

      def label_attribute
        :email
      end
    end
  end
end