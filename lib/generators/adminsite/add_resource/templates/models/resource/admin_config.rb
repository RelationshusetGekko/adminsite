class <%= @resource_class %>
  module AdminConfig

    class << self

      def attributes_index
        [ :id,
          :name
        ]
      end

      def attributes_edit
        [ :name ]
      end

      def attributes_show
        attributes_edit + [:updated_at]
      end

      def index_actions
        [ :show,
          :edit,
          :destroy]
      end

      def label_attribute
        :title
      end
    end
  end
end