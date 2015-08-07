class Admin::<%= @resource_class %>sController < Admin::ResourcesController

  private

  def resource_class
    <%= @resource_class %>
  end

end