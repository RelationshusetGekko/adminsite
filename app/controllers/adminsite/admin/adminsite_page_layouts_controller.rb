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

  protected

  def self.resource_class
    Adminsite::PageLayout
  end

  def order_params
    'title ASC'
  end

  def resource_admin_config
    # Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
    # -> Result: "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" || Adminsite::AdminConfig::Base
    super
  end

  # self.register_routes
end