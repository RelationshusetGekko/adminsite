if Rails.env.production?
  # Paperclip::Attachment.default_options.update({
  #   :path => "images/:id/:basename.:extension",
  #   :storage => :fog, # -> requires 'fog' gem
  #   :fog_credentials => {
  #     :provider           => 'Rackspace',
  #     :rackspace_username => 'XXXXXX',
  #     :rackspace_api_key  => 'XXXXXX',
  #     :persistent => false
  #   },
  #   :fog_directory => 'XXXXXX',
  #   :fog_public => true,
  #   :fog_host => 'https://XXXXXX.ssl.cf1.rackcdn.com'
  # })
end