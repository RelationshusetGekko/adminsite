%w(rails action_controller/page_caching p3p).each{|f| require f }
%w(paperclip liquid adminsite/liquid/tags/asset).each{|f| require f }
%w(devise haml cocaine formtastic).each{|f| require f }

module Adminsite
  class Engine < Rails::Engine
    isolate_namespace Adminsite

    # config.generators.integration_tool    :rspec
    # config.generators.test_framework      :rspec

    initializer "adminsite.assets.precompile" do |app|
      app.config.assets.precompile |= %w( adminsite.css adminsite.js )
    end

    initializer :adminsite do
      Adminsite::Engine.config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"

      # Make sure to load adminsite controllers to initalize adminsite resource routing
      load_paths( [ Adminsite::Engine.root, Rails.root].collect{|r| "#{r}/app/controllers/adminsite/admin/**/*.*" } )
    end

    def load_paths(paths)
      paths.each do |path|
        Dir.glob(path).each{|f| require f }
      end
    end

  end
end