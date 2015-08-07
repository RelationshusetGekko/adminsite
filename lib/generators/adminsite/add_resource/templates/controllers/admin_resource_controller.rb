class Admin::<%= resource_class =%>< Admin::ResourceController

  private

  def resource_class
    <%= resource_class =%>
  end

end