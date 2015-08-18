# encoding: utf-8
module Adminsite
  class Configuration

    attr_accessor :admin_namespace # :admin

    # Configuration defaults
    def initialize
      @admin_namespace                        = :admin_namespace
    end

  end
end


