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
        template  "controllers/admin_resource_controller.rb", "app/controllers/adminsite/admin/#{table_name}_controller.rb"

        # Models
        template  "admin_configs/resource_admin_config.rb", "app/admin_configs/adminsite/#{file_name}_admin_config.rb"

        # Content-Menu
        inject_into_file "app/views/adminsite/admin/shared/_content_menu.html.haml", :after => /\#content_menu.menu\n .*\s\%ul/ do
          "\n    = menu_item '#{class_name.camelize.pluralize}', admin_#{table_name}_path, '#{table_name}'"
        end

      end

    end
  end
end