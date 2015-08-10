class Admin::AdminsController < Admin::ResourcesController

  protected

  def resource_class
    Admin
  end

  def order_params
    'email ASC'
  end

end