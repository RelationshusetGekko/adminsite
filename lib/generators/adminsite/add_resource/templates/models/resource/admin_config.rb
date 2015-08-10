class <%= @resource_class %>
  module AdminConfig

    def self.attributes_index
      [ :id,
        :name
      ]
    end

    def self.attributes_edit
      [ :name ]
    end

    def self.attributes_show
      attributes_edit
    end

    def self.index_actions
      [ :show,
        :edit,
        :destroy]
    end
  end
end