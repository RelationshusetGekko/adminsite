module <%= class_name.camelize %>::Exports
  def self.included(base)
    base.instance_eval do
      comma do
        id
        created_at
        updated_at
      end
    end
  end

  class << self
    def full
      %w[id
        created_at
        updated_at]
    end
  end
end