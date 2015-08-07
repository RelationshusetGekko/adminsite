class <%= @resource_class %>
  module AdminConfig

    def self.attributes_index
      [ :id ]
    end

    def self.attributes_edit
      [ :id ]
    end

    def self.attributes_show
      attributes_edit
    end

    def self.index_actions
      [ :edit,
        :destroy]
    end
  end
end