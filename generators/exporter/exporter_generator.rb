require File.expand_path(File.dirname(__FILE__) + "/../lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/../lib/rake_commands.rb")

class ExporterGenerator < Rails::Generator::NamedBase
  def manifest(Classname, export_type)
    puts "Generate exporter"¨
    record do |m|
      # Config
      # "config/routes_hook.rb"

      # Controller
      m.file "controllers/_exports_controller.rb", "app/controllers/admin/#{file_name}_exports_controller.rb"

      # Models
      create_xlsx = (type.lowercase != "csv")
      create_csv = (type.lowercase != "xlsx")

      if create_xlsx
        m.file "models/_exporter.rb", "app/models/#{file_name}_xlsx_exporter.rb"
        # "models/export_hook_xlsx.rb"
      end

      if create_csv
        m.file "models/_exporter.rb", "app/models/#{file_name}_csv_exporter.rb"
        # "models/export_hook_csv.rb"
      end

      # Views
      m.directory "app/views/admin/#{file_name}_exports"
      m.file "views/index.html.haml", "app/views/admin/#{file_name}_exports/index.html.haml"

    end
  end
end