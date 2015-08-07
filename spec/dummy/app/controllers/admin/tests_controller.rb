class Admin::TestsController < Admin::ResourcesController

  private

  def resource_class
    Page
  end

end