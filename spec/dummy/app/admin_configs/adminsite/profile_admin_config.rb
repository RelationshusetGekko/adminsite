module Adminsite
  class ProfileAdminConfig < Adminsite::AdminConfig::Base

    # def ignore_columns
    #   ['created_at', 'updated_at', 'id']
    # end

    # def column_names
    #   @column_names ||= resource_class.column_names
    # end

    def attributes_index
      [:id, :email, :first_name, :last_name, :utm_source ] #column_names
    end

    # def attributes_edit(resource = nil)
    #   @attributes_edit ||= (column_names - ignore_columns)
    # end

    # def attributes_show(resource = nil)
    #   attributes_edit
    # end

    # def default_member_actions(resource = nil)
    #   [ :show,
    #     :edit,
    #     :destroy]
    # end

    # def actions_index
    #   [ :new ]
    # end

    def label_attribute(resource = nil)
      :first_name
    end

  end
end