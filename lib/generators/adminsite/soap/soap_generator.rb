module Adminsite
  module Generators
    class SoapGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def run_generation

        run ('bundle')
      end
    end
  end
end