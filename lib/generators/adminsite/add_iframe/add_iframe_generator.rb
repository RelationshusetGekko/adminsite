  require 'uri'
  module Adminsite
    module Generators
      class AddIframeGenerator < Rails::Generators::NamedBase
        source_root File.expand_path("../templates", __FILE__)


      def run_generation
        require 'domainatrix'

        url_parsed = Domainatrix.parse(name)
        @url = url_parsed.url
        @domain = url_parsed.domain
        puts "domain underscore : '#{@domain.underscore}'"
        @file_name = @domain.underscore.gsub('/','_')

       raise "Domain missing or not valid" if @domain.blank?

        puts "my first iframe for domain: '#{@domain}' with url: '#{@url}'"
        template  "controllers/admin_iframe_controller.rb", "app/controllers/adminsite/admin/#{@file_name}_controller.rb"

        # Content-Menu
        inject_into_file "app/views/adminsite/admin/shared/_admin_menu.html.haml", :after => /\= yield :admin_menu\n/ do\
          "\n    = menu_item 'IFrame-#{@domain.camelize}', admin_#{@file_name}_index_path, ['#{@domain}_index']\n"
        end

     end
    end
   end
end