require 'adminsite'
require 'rails'
require 'action_controller'

module Adminsite
  class Engine < Rails::Engine
    paths.app                 = "app"
    paths.app.controllers     = "app/controllers"
    paths.app.helpers         = "app/helpers"
    paths.app.models          = "app/models"
    # paths.app.metals          = "app/metal"
    paths.app.views           = "app/views"

    # paths.lib                 = "lib"
    # paths.lib.tasks           = "lib/adminsite/tasks.rb"
    # paths.config              = "config"
    # paths.config.initializers = "config/initializers"
    # paths.config.locales      = "config/locales"
    # paths.config.routes       = "config/routes.rb"

    # Load rake tasks
    # rake_tasks do
    #   load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
    # end
  end
end