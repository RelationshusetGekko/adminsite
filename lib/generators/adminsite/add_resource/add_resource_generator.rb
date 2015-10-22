module Adminsite
  module Generators
    class AddResourceGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def table_name
        class_name_underscore.pluralize
      end

      #def file_name
      #  super.underscore.gsub('/','_')
      #end

      def class_name_underscore
        class_name.underscore.gsub('/','_')
      end

      def run_generation
        puts "Setting up resource #{class_name.camelize} for Adminsite"
        @resource_class = class_name.camelize

        #puts "file_name: #{file_name}"
        puts "table_name: #{table_name}"

        # Controllers
        template  "controllers/admin_resource_controller.rb", "app/controllers/adminsite/admin/#{table_name}_controller.rb"

        # Models
        template  "admin_configs/resource_admin_config.rb", "app/admin_configs/adminsite/#{class_name_underscore}_admin_config.rb"

        # Content-Menu
        inject_into_file "app/views/adminsite/admin/shared/_admin_menu.html.haml", :after => /\= yield :admin_menu\n/ do\
          "\n    = menu_item '#{class_name.camelize}Mngt', admin_#{table_name}_path, ['#{table_name}']\n"
        end

      end

    end
  end
end
