class AdminsiteImporterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def run_generation
    puts "Setting up Adminsite to import #{class_name} "

    template  "class_importer_task.rake", "lib/tasks/#{class_name.downcase}_importer.rake"

  end
end