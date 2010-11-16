require File.expand_path(File.dirname(__FILE__) + "/../lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/../lib/rake_commands.rb")

class AdminsiteGenerator < Rails::Generator::Base
  def manifest
    puts "Setting up Adminsite to work with your Rails #{Rails.version} app"
    record do |m|
      m.append_to 'Rakefile', IO.read(source_path('rakefile_hook.rb'))
      m.template 'routes.rb', 'config/routes.rb'

      FileUtils.mkdir_p 'views/admin/shared'
      m.template '_menu.haml', 'views/admin/shared/_menu.haml'

      FileUtils.mkdir_p 'lib/recipes'
      m.template 'application.rb', 'lib/recipes/application.rb'

      File.delete("public/index.html") if File.exist?("public/index.html")
      m.rake "adminsite:sync", :generate_only => true
      m.rake "db:migrate", :generate_only => true
      m.rake "adminsite:setup", :generate_only => true
    end
  end
end