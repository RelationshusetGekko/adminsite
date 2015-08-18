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

  def resource_admin_config
    # Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
    # -> Result: "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" || Adminsite::AdminConfig::Base
    super
  end

  def resource_class
    Adminsite::Page
  end

  def order_params
    'title ASC'
  end

end