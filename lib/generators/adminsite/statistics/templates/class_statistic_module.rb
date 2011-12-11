module <%= class_name.camelize %>::Statistic
  class << self

    def caching
      return { :cache_for => cache_ttl } if cache_ttl_allowed?
      {}
    end

    def cache_ttl
      5.minutes
    end

    def cache_ttl_allowed?
      # Only MemCache supports the :expires_in/:cache_for parameter
      Rails.cache.is_a?(ActiveSupport::Cache::MemCacheStore)
    end

    def included(base)
      base.instance_eval do

        with_options <%= class_name.camelize %>::Statistic.caching.merge(:count => :all) do |c|

          # General Counts
          c.define_statistic :all_count,                   :count => :all

        end # with_options

      end # base.instance_eval
    end # included

  end # class
end