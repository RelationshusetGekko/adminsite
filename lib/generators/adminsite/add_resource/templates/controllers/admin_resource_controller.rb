class Admin::<%= @resource_class %>sController < Admin::ResourcesController

  private

  def filter_scopes
    []
  end

  def order_params
    'ID DESC'
  end

  def resource_class
    <%= @resource_class %>
  end

  def resource_admin_config
    "Adminsite::#{resource_class}::AdminConfig"
  end

end