class Adminsite::Admin::<%= @controller_name.camelize.gsub('::','') %>Controller < Adminsite::Admin::IframeController

  private

  class << self

    def iframe_url
      '<%= @url %>'
    end

    def iframe_name
      '<%= @controller_name %>'
    end
  end

  self.register_routes

end