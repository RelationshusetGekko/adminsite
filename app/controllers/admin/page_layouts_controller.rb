class Admin::PageLayoutsController < Admin::ResourcesController

  def new
    @resource = PageLayout.new(:body => "{{content_for_template}}")
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
    Page.cleanup_all_cached
  end

  def destroy
    Page.cleanup_all_cached
    super
  end

  def resource_class
    PageLayout
  end

  def order_params
    'title ASC'
  end
end