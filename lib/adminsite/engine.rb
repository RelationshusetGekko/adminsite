require 'rails'
require 'action_controller/page_caching'
require 'paperclip'
require 'liquid'
require 'adminsite/liquid/tags/asset'
require 'devise'
require 'haml'
require 'cocaine'

module Adminsite
  class Engine < Rails::Engine
    isolate_namespace Adminsite

    # config.generators.integration_tool    :rspec
    # config.generators.test_framework      :rspec

    initializer :adminsite do
      Adminsite::Engine.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"
    end

    # initializer "adminsite.assets.precompile" do |app|
    #   app.config.assets.precompile |= %w( adminsite/admin.css adminsite/admin.js )
    # end

    # initializer :adminsite do
    # end
  end
end