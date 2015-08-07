class Admin::TestsController < Admin::ResourcesController

  private

  def resource_class
    Page
  end

  def resource_admin_config
    Test::AdminConfig
  end

end