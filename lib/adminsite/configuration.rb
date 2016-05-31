# encoding: utf-8
module Adminsite
  class Configuration

    attr_accessor :admin_namespace # :admin

    attr_accessor :title

    # Configuration defaults
    def initialize
      @title                                  = Rails.application.class.parent_name.titleize
      @admin_namespace                        = :admin
    end

  end
end


