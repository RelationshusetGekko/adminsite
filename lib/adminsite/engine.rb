%w(rails action_controller/page_caching p3p).each{|f| require f }
%w(paperclip liquid adminsite/liquid/tags/asset).each{|f| require f }
%w(devise haml cocaine formtastic).each{|f| require f }

module Adminsite
  class Engine < Rails::Engine
    isolate_namespace Adminsite

    # config.generators.integration_tool    :rspec
    # config.generators.test_framework      :rspec

    config.autoload_paths << "#{Adminsite::Engine.root}/app/models/adminsite"
    config.autoload_paths << "#{Adminsite::Engine.root}/app/models/adminsite/admin_config"
    config.autoload_paths << "#{Adminsite::Engine.root}/app/controllers/adminsite/admin"
    config.autoload_paths << "#{Rails.root}/app/models/adminsite"

    initializer :adminsite do
      Adminsite::Engine.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"
      config.autoload_paths.each do |path|
        Dir.glob("#{path}/*.*").each{|f| require f }
      end
    end

    # initializer "adminsite.assets.precompile" do |app|
    #   app.config.assets.precompile |= %w( adminsite/admin.css adminsite/admin.js )
    # end

    # initializer :adminsite do
    # end
  end
end