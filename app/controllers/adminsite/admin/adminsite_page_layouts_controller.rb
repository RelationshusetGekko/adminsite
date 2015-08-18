class Adminsite::Admin::AdminsitePageLayoutsController < Adminsite::Admin::ResourcesController

  def new
    @resource = resource_class.new(:body => "{{content_for_template}}")
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
    Adminsite::Page.cleanup_all_cached
  end

  def destroy
    Adminsite::Page.cleanup_all_cached
    super
  end

  def resource_class
    Adminsite::PageLayout
  end

  def order_params
    'title ASC'
  end
end