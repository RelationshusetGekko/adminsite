class Adminsite::Admin::<%= @file_name.camelize.gsub('::','') %>Controller < Adminsite::Admin::IframeController

  private

  class << self

    def iframe_url
      '<%= @url %>'
    end

    def iframe_name
      '<%= @domain %>'
    end
  end

  self.register_routes

end