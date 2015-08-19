class Adminsite::Admin::ProfilesController < Adminsite::Admin::ResourcesController

  private

  def filter_scopes
    []
  end

  def order_params
    'ID DESC'
  end

  def self.resource_class
    Profile
  end

  def resource_admin_config
    # Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
    # -> Result: "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" || Adminsite::AdminConfig::Base
    super
  end

    self.register_routes

end