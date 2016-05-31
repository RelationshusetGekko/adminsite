module Adminsite
    module Generators
      class AddDashboardGenerator < Rails::Generators::Base
        source_root File.expand_path("../templates", __FILE__)


      def run_generation


       @title = "Override Me !!!"


        #puts "my first iframe for controller_name'#{@controller_name}' }'"
        template  "controllers/admin_dashboard_controller.rb", "app/controllers/adminsite/admin/dashbord_controller.rb"

        template  "views/index.html.haml", "app/views/adminsite/admin/dashboard/index.html.haml"

        template  "views/index.html.haml", "app/views/adminsite/admin/dashboard/index.html.haml"

        # Content-Menu
        inject_into_file "app/views/adminsite/admin/shared/_admin_menu.html.haml", :after => /\= yield :admin_menu\n/ do\
        # "\n    = menu_item 'IFrameMgt', admin_#Dashboard_index_path, ['#{@file_name}']\n"
         "\n    = menu_item 'Dashboard', admin_dashboard_index_path "
        end




     end




    end
   end
end