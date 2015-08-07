module Adminsite
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      def run_generation
        #append_file 'Rakefile', "require 'adminsite/tasks'"
        run ('rails generate devise:install')
        template 'application.rb', 'lib/recipes/application.rb'

        template '_admin_menu.html.haml', 'app/views/admin/shared/_admin_menu.haml'
        template '_content_menu.html.haml', 'app/views/admin/shared/_content_menu.haml'

        if File.exists?("#{destination_root}/app/views/layouts/application.html.erb")
          copy_file "#{destination_root}/app/views/layouts/application.html.erb",  'app/views/layouts/application.html.erb.onsolete'
        end

        ['public/index.html', 'app/views/layouts/application.html.erb'].each do |f|
          f = "#{destination_root}/#{f}"
          remove_file f if File.exists?(f)
        end

        rake "adminsite:install:migrations", :generate_only => true
        rake "adminsite:sync",               :generate_only => true
        rake "db:migrate",                   :generate_only => true
        rake "adminsite:create_admin",       :generate_only => true
      end

      def after_generate
        # puts "#{'*'*70}"
        # puts "If we need to say something after install we do it here."
        # puts "#{'*'*70}"
      end
    end
  end
end