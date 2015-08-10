require Adminsite::Engine.root.join('app/models/admin')

module Adminsite
  module Admin
    module AdminConfig

      class << self

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
end