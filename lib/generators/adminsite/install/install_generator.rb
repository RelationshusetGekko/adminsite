module Adminsite
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      def run_generation
        # append_file 'Rakefile', "require 'adminsite/tasks'"
        run ('rails generate devise:install')
        template 'recipes/application.rb', 'lib/recipes/application.rb'

        template 'views/_admin_menu.html.haml', 'app/views/adminsite/admin/shared/_admin_menu.html.haml'

        template 'assets/adminsite.js', 'app/assets/javascripts/adminsite.js'
        template 'assets/adminsite.scss', 'app/assets/stylesheets/adminsite.scss'

        if File.exists?("#{destination_root}/app/views/layouts/application.html.erb")
          copy_file "#{destination_root}/app/views/layouts/application.html.erb",  'app/views/layouts/application.html.erb.onsolete'
        end

        ['public/index.html', 'app/views/layouts/application.html.erb'].each do |f|
          f = "#{destination_root}/#{f}"
          remove_file f if File.exists?(f)
        end

        inject_into_file 'config/routes.rb', after: /\ARails.application.routes.draw do/ do
          "\n  mount ::Adminsite::Engine => '/' \n"+
          "# Defines root path. If survey or other gem have to serve root_path u have to comment line below \n"+
          " root :to => 'adminsite/contents#show', :page_url => 'index' \n"
        end

        inject_into_file 'config/routes.rb', before: /end[\s]*\z/ do
          "# Should be last to render 404 if routing not found \n"+
          "\n  get '/:page_url(.:format)' => 'adminsite/contents#render_404'\n"
        end

        rake "adminsite:install:migrations", :generate_only => true
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