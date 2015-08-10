class Admin::PagesController < Admin::ResourcesController

  def new
    @file_assets = FileAsset.all
    super
  end

  def edit
    @file_assets = FileAsset.all
    super
  end

  def update
    @file_assets = FileAsset.all
    super
    @resource.cleanup_cached
  end

  def destroy
    @resource.cleanup_cached
    super
  end

  protected

  def resource_class
    Page
  end

  def order_params
    'title ASC'
  end

end