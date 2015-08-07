class Test
  module AdminConfig

    def self.attributes_index
      [ :id ]
    end

    def self.index_actions
      [ :edit,
        :destroy]
    end
  end
end