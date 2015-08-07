module Test
  module AdminConfig

    def self.attributes_index
      [ :id ]
    end

    def self.actions_index
      [ :edit,
        :destroy]
    end
  end
end