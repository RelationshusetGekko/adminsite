class FileAsset < ActiveRecord::Base

  has_attached_file :attachment

  validates_with AttachmentPresenceValidator, :attributes => :attachment
  validates_with AttachmentSizeValidator, :attributes => :attachment, :less_than => 2.megabytes
  validates_attachment :attachment, content_type: { content_type: /\A.*\Z/ }
  # do_not_validate_attachment_file_type :image

  class << self
    def attachment_url_for(name)
      asset = find_by_attachment_file_name(name)
      if asset.nil?
        "http://missing.jpg?#{name}"
      else
        asset.attachment.url(:original, false)
      end
    end
  end
end
