# Adminsite
require "rails"
require 'paperclip'
require 'liquid'
require 'adminsite/liquid/tags/asset'
require 'devise'
require 'haml'

module Adminsite
  require 'engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end
