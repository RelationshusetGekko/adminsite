require "adminsite/engine"
require 'adminsite/configuration'

module Adminsite
  class << self
    def configure
      yield configuration
    end

    # Accessor for Adminsite::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration
  end
end
