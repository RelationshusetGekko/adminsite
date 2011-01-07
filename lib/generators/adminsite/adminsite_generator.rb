class AdminsiteGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  def run_generation
    #append_file 'Rakefile', "require 'adminsite/tasks'"
    FileUtils.mkdir_p 'lib/recipes'
    template 'application.rb', 'lib/recipes/application.rb'

    FileUtils.mkdir_p 'app/views/admin/shared'
    template '_menu.html.haml', 'app/views/admin/shared/_menu.haml'

    File.delete("public/index.html") if File.exist?("public/index.html")

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