class Admin::<%= @resource_class %>sController < Admin::ResourcesController

  private

  def resource_class
    <%= @resource_class %>
  end

  def resource_admin_config
    resource_class::AdminConfig
  end

end