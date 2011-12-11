module Adminsite
  module Generators
    class SoapGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def run_generation
        puts "Setting up soap connector for #{class_name.camelize}"

        template  "base_class_connector.rb", "app/models/soap_base_#{class_name.underscore}.rb"
        template  "class_connector.rb", "app/models/soap_base_#{class_name.underscore}s/#{class_name.underscore}.rb"

        # Gemfile
        inject_into_file "Gemfile", :before => /^.*gem ['"]adminsite['"]/ do
          "gem 'savon'\n"
        end

        run ('bundle')

        puts "*" * 80
        puts ""
        puts "Don't forget to add the path app/models/soap_base_#{class_name.underscore}s into the autoload_paths"
        puts ""
        puts "*" * 80

      end
    end
  end
end