class AdminsiteExporterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def run_generation
    puts "Setting up Adminsite to export #{class_name} "

    template  "klass_exports_controller.rb", "app/controllers/admin/#{file_name}_exports_controller.rb"
    template  "index.haml.erb", "app/views/admin/#{file_name}_exports/index.html.haml"
    template  "klass_export.rb", "app/models/#{file_name}_export.rb"
    template  "exports.rb", "app/models/#{file_name}/exports.rb"
    inject_into_class "app/models/#{file_name}.rb", class_name do
      "  include #{class_name}::Exports\n"
    end
    inject_into_file "config/routes.rb", :after => /\.routes\.draw do\s*\n/ do
      "  namespace :admin do\n    resources :#{file_name}_exports\n  end\n"
    end
    append_file "Rakefile", 'task "resque:setup" => :environment'
    template  "file_export_timeformats.rb", "config/initializers/file_export_timeformats.rb"
    inject_into_file "app/views/admin/shared/_menu.haml", :before => /^.*destroy_admin_session_path/ do
      "    = menu_item '#{class_name} exports', admin_#{file_name}_exports_path, '#{file_name}_exports'\n"
    end
    # Gemfile
    inject_into_file "Gemfile", :before => /^.*gem ['"]adminsite['"]/ do
      "gem 'comma'\n"+
      "gem 'builder' # Explicit require before simple_xlsx_writer\n"+
      "gem 'broadcamp56-simple_xlsx_writer', '~> 0.5.4',\n"+
      "   :require => 'simple_xlsx',\n"+
      "   :git     => 'git@github.com:Broadcamp56/simple_xlsx_writer.git',\n"+
      "   :branch  => 'master'\n"
    end
  end
end