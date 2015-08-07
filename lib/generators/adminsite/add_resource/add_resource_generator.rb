module Adminsite
  module Generators
    class AddResourceGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def table_name
        file_name.pluralize
      end


      def run_generation
        puts "Setting up resource #{class_name.camelize} for Adminsite"
        @resource_class = class_name.camelize

        # Controllers
        template  "controllers/admin_resource_controller.rb", "app/controllers/admin/#{table_name}_controller.rb"

        # Models
        template  "models/resource/admin_config.rb", "app/models/#{file_name}/admin_config.rb"

        # Routing
        inject_into_file "config/routes.rb", :after => /\.routes\.draw do\s*\n/ do
          "  namespace :admin do\n    resources :#{table_name}\n  end\n"
        end

        # Content-Menu
        inject_into_file "app/views/admin/shared/_content_menu.haml", :after => /\#content_menu.menu\n .*\s\%ul/ do
          "\n    = menu_item '#{class_name.camelize.pluralize}', admin_#{table_name}_path, '#{table_name}'\n"
        end

      end

    end
  end
end