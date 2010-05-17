class FileAsset < ActiveRecord::Base
  # IF PAPERCLIP_CONTAINER is not defined we fall back to local filesystem
  begin
    STORAGE = { :storage => :cloud_files,
                :container => PAPERCLIP_CONTAINER,
                :cloudfiles_credentials => "config/mosso_cloudfiles.yml",
                :path => "assets/:id/:filename" }
  rescue
    STORAGE = { :path => ":rails_root/public/system/flash/:filename",
                :url  => "/system/flash/:filename" }
  end

  has_attached_file :attachment, STORAGE

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
