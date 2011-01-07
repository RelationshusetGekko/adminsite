class AdminsiteGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  def run_generation
    #append_file 'Rakefile', "require 'adminsite/tasks'"
    template 'application.rb', 'lib/recipes/application.rb'
    template '_menu.html.haml', 'app/views/admin/shared/_menu.haml'
    remove_file 'public/index.html'
    remove_file 'app/views/layouts/application.html.erb'

    rake "adminsite:sync",  :generate_only => true
    rake "db:migrate",      :generate_only => true
    rake "adminsite:setup", :generate_only => true
  end

  def after_generate
    # puts "#{'*'*70}"
    # puts "If we need to say something after install we do it here."
    # puts "#{'*'*70}"
  end
end