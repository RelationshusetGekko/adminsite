class Adminsite::Admin::<%= @resource_class.gsub('::','') %>sController < Adminsite::Admin::ResourcesController

  private

  def order_params
    'ID DESC'
  end

  def self.resource_class
    <%= @resource_class %>
  end

  def resource_admin_config
    # Adminsite::Admin::ResourcesController.resource_admin_config
    super
  end

end