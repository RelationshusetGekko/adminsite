module Adminsite
  class AdminsiteFileAssetAdminConfig < Adminsite::AdminConfig::Base

    def attributes_index
      [ 'attachment.url',
        'attachment_file_name',
        'attachment_file_size',
        'updated_at',
      ]
    end

    def attributes_show(resource = nil)
      ['attachment.url'] + attributes_edit
    end

    def actions_index
      [ ]
    end

    def attributes_search
      attributes_index
    end

    def default_member_actions(resource = nil)
      [ :show, :destroy ]
    end

    def label_attribute(resource = nil)
      :attachment_file_name
    end
  end
end