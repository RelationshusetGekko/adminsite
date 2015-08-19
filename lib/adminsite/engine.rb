%w(rails action_controller/page_caching p3p).each{|f| require f }
%w(paperclip liquid adminsite/liquid/tags/asset).each{|f| require f }
%w(devise haml cocaine formtastic).each{|f| require f }

module Adminsite
  class Engine < Rails::Engine
    isolate_namespace Adminsite

    # config.generators.integration_tool    :rspec
    # config.generators.test_framework      :rspec

    config.autoload_paths |= [
      "#{Adminsite::Engine.root}/app/models/adminsite",
      "#{Adminsite::Engine.root}/app/admin_configs/adminsite",
      "#{Adminsite::Engine.root}/app/controllers/adminsite/admin"
    ]

    # initializer "adminsite.assets.precompile" do |app|
    #   app.config.assets.precompile |= %w( adminsite/admin.css adminsite/admin.js )
    # end

    initializer :adminsite do
      Adminsite::Engine.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"

      # Have to be done here, to be sure Rails.root is set
      config.autoload_paths |= [
        "#{Rails.root}/app/admin_configs/adminsite",
        "#{Rails.root}/app/controllers/adminsite/admin"
      ]

      load_adminsite_autoload_paths
    end

    def load_adminsite_autoload_paths
      config.autoload_paths.each do |path|
        Dir.glob("#{path}/*.*").each{|f| require f }
      end
    end
  end
end