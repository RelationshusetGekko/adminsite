require "adminsite/engine"
require 'adminsite/configuration'

module Adminsite
  class << self
    def configure
      yield configuration
    end

    # Accessor for Adminsite::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def register_routes(rails_router)
      Adminsite::Admin::CrudController.descendants.each{|d| d.register_routes(rails_router) }
      rails_router
    end
  end
end
