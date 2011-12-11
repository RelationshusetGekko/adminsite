module Adminsite
  module Generators
    class ImporterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def run_generation
        puts "Setting up Adminsite to import #{class_name.camelize} "

        template  "class_importer_task.rake", "lib/tasks/#{class_name.underscore}_importer.rake"

        # Gemfile
        inject_into_file "Gemfile", :before => /^.*gem ['"]adminsite['"]/ do
          "gem 'fastercsv'\n"
        end

        run ('bundle')
      end
    end
  end
end