class Adminsite::Admin::AdminsitePagesController < Adminsite::Admin::ResourcesController

  def new
    @file_assets = Adminsite::FileAsset.all
    super
  end

  def edit
    @file_assets = Adminsite::FileAsset.all
    super
  end

  def update
    @file_assets = Adminsite::FileAsset.all
    super
    @resource.cleanup_cached
  end

  def destroy
    @resource.cleanup_cached
    super
  end

  protected

  def order_params
    'title ASC'
  end

  def resource_admin_config
    # Adminsite::Admin::ResourcesController.resource_admin_config
    super
  end

  def self.resource_class
    Adminsite::Page
  end

end