require File.expand_path(File.dirname(__FILE__) + "/../lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/../lib/rake_commands.rb")

class AdminsiteExporterGenerator < Rails::Generator::NamedBase
  def manifest
    puts "Setting up Adminsite to export #{class_name}"
    record do |m|
      m.directory "app/controllers/admin"
      m.template  "klass_exports_controller.rb", "app/controllers/admin/#{file_name}_exports_controller.rb"
      m.directory "app/views/admin/#{file_name}_exports"
      m.template  "index.haml.erb", "app/views/admin/#{file_name}_exports/index.haml"
      m.template  "klass_export.rb", "app/models/#{file_name}_export.rb"
      m.directory "app/models/#{file_name}"
      m.template  "exports.rb", "app/models/#{file_name}/exports.rb"
      m.insert_into "app/models/#{file_name}.rb", "include #{class_name}::Exports"
      m.route_namespaced_resources :admin, "#{file_name}_exports"
      m.append_to "Rakefile", 'task "resque:setup" => :environment'
      m.template  "file_export_timeformats.rb", "config/initializers/file_export_timeformats.rb"
      menu_tab_creation_message
    end
  end

  private
  def menu_tab_creation_message
    puts "\n\n"
    puts "#{'*'*60}"
    puts "You can now add a tab in the top menu if you want."
    puts "be sure you have a menu file in:"
    puts "view/admin/shared/_menu.html.haml"
    puts "and add this line:"
    puts "=menu_item('#{class_name} Exports', admin_#{file_name}_exports_path)"
    puts "#{'*'*60}"
  end

end