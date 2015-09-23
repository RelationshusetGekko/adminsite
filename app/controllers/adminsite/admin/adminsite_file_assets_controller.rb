class Adminsite::Admin::AdminsiteFileAssetsController < Adminsite::Admin::ResourcesController

  def index
    @file_asset = Adminsite::FileAsset.new
    super
  end

  def create
    success_files = []
    failure_files = []

    if params[:file_asset].present?
      Array(permitted_params[:file_asset][:attachment]).each do |file|
        filename = file.original_filename

        # "Overwrite" existing by removing them
        Adminsite::FileAsset.find_by_attachment_file_name(filename).try(:destroy)

        file_asset = Adminsite::FileAsset.new('attachment' => file)
        if file_asset.save!
          success_files << "'#{filename}'"
        else
          failure_files << "'#{filename}'"
        end
      end
    end

    flash[:notice] = "File(s) #{success_files.join(', ')} were successfully uploaded." if success_files.any?
    flash[:errors] = "File(s) #{failure_files.join(', ')} were not uploaded."          if failure_files.any?

    Adminsite::Page.cleanup_all_cached
    redirect_to admin_adminsite_file_assets_path
  end

  def destroy
    super
    Adminsite::Page.cleanup_all_cached
    # redirect_to admin_adminsite_file_assets_path
  end

  protected

  def order_params
    'attachment_file_name ASC'
  end

  def resource_admin_config
    # Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
    # -> Result: "Adminsite::AdminConfig::#{config_class_name.gsub('::','')}" || Adminsite::AdminConfig::Base
    super
  end

  def self.resource_class
    Adminsite::FileAsset
  end

end