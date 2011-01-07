class AdminsiteExporterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def run_generation
    puts "Setting up Adminsite to export #{class_name} "
    empty_directory "app/controllers/admin"
    template  "klass_exports_controller.rb", "app/controllers/admin/#{file_name}_exports_controller.rb"
    empty_directory "app/views/admin/#{file_name}_exports"
    template  "index.haml.erb", "app/views/admin/#{file_name}_exports/index.haml"
    template  "klass_export.rb", "app/models/#{file_name}_export.rb"
    empty_directory "app/models/#{file_name}"
    template  "exports.rb", "app/models/#{file_name}/exports.rb"
    inject_into_class "app/models/product.rb", class_name do
      "  include #{class_name}::Exports\n"
    end
    inject_into_file "config/routes.rb", :after => /\.routes\.draw do\s*\n/ do
      "  namespace :admin do resources :#{file_name}_exports end\n"
    end
    append_file "Rakefile", 'task "resque:setup" => :environment'
    template  "file_export_timeformats.rb", "config/initializers/file_export_timeformats.rb"
    inject_into_file "app/views/admin/shared/_menu.haml", :before => /=menu_item\('\Log out\', logout_path\)\s*\n/ do
      "    =menu_item('#{class_name} Exports', admin_#{file_name}_exports_path)\n    "
    end
  end

  def after_generate
    puts "\n\n"
    puts "#{'*'*60}"
    puts "You can now add a tab in the top menu if you want."
    puts "be sure you have a menu file in:"
    puts "view/admin/shared/_menu.html.haml"
    puts "and add this line:"
    puts "=menu_item('#{class_name} Exports', admin_#{file_name}_exports_path)"
    puts "#{'*'*60}"
  end

  private

end