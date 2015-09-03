module Adminsite
  module AdminConfig
    class Base   #

      @@admin_configs = {}

      class << self

        def admin_default_config_class(class_name)
          config_class = 'Adminsite::AdminConfig::Base'
          return config_class if class_name.blank?

          config_class_name = class_name.to_s.gsub('::','')
          begin
            # Test if "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" is defined
            config_class = "Adminsite::#{config_class_name}AdminConfig"
            eval(config_class)
          rescue NameError, LoadError => e
            puts("AdminConfig for #{config_class_name} not found. Use fallback: #{config_class}")
            Rails.logger.warn("AdminConfig for #{config_class_name} not found. Use fallback: #{config_class}")
          end
          config_class
        end

        def admin_config_of_class(class_name, admin_config_class = nil)
          admin_config_class ||= @@admin_configs[class_name.to_s]
          if admin_config_class.blank?
            admin_config_class = admin_default_config_class(class_name.to_s)
            register_admin_configs(class_name.to_s, admin_config_class)
          end
          # puts "all_registered_admin_configs: #{Adminsite::AdminConfig::Base.all_registered_admin_configs.inspect}"
          eval(admin_config_class).new(class_name)
        end

        def register_admin_configs(class_name, admin_config, override = true)
          if override
            @@admin_configs[class_name] = admin_config
          else
            @@admin_configs[class_name] ||= admin_config
          end
        end

        def all_registered_admin_configs
          @@admin_configs
        end
      end

      attr_reader :resource_class

      def ignore_columns
        ['created_at', 'updated_at', 'id']
      end

      def column_names
        @column_names ||= resource_class.column_names
      end

      def attributes_index
        column_names
      end

      def attributes_edit
        @attributes_edit ||= (column_names - ignore_columns)
      end

      def attributes_show
        attributes_edit
      end

      def default_member_actions
        [ :show,
          :edit,
          :destroy]
      end

      def actions_index
        [ :new ]
      end

      def label_attribute
        :title
      end

      protected

      def initialize(resource_class)
        require Adminsite::Engine.root.join("app/models/#{resource_class.name.underscore}") unless defined?(resource_class)
        @resource_class = resource_class
      end

    end
  end
end