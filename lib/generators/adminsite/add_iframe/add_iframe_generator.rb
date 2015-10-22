  require 'uri'
  module Adminsite
    module Generators
      class AddIframeGenerator < Rails::Generators::Base
        source_root File.expand_path("../templates", __FILE__)

        argument :url,
                 :type                    => :string,
                 :desc                    => "The url ex: www.google.com",
                 :required                => true

        argument :controller_name,
                 :type                    => :string,
                 :desc                    => "ex : GoogleSearch ",
                 :required                => false


      def run_generation
        require 'domainatrix'

        url_parsed = Domainatrix.parse(url)
        @url = url_parsed.url
        @domain = url_parsed.domain
        @controller_name = controller_name || "#{@domain}Iframe"

        @file_name = @controller_name.underscore.gsub('/','_')
        puts "file_name: '#{@file_name}'"

       raise "Domain missing or not valid" if @domain.blank?

        puts "my first iframe for domain: '#{@controller_name}' with url: '#{@url}'"
        template  "controllers/admin_iframe_controller.rb", "app/controllers/adminsite/admin/#{@file_name}_controller.rb"

        # Content-Menu
        inject_into_file "app/views/adminsite/admin/shared/_admin_menu.html.haml", :after => /\= yield :admin_menu\n/ do\
          "\n    = menu_item 'IFrameMgt', admin_#{@file_name}_index_path, ['#{@file_name}']\n"
        end

     end
    end
   end
end