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
      puts "Adminsite.register_routes"
      load_controllers if Adminsite::Admin::CrudController.descendants.blank?
      Adminsite::Admin::CrudController.descendants.each{|d| d.register_routes(rails_router) }
      rails_router
    end

    def load_controllers
      puts "Adminsite.load_controllers"
      Gem.find_files('../app/controllers/**/admin/**/*_controller.rb').each do |c|
        load(c)
      end
    end
  end
end