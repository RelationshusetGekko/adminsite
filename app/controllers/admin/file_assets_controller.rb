class Admin::FileAssetsController < Admin::BaseController
  unloadable

  before_filter :ensure_file_upload_array, :only => :create

  def index
    @file_assets = FileAsset.all
    @file_asset = FileAsset.new
  end

  def create
    success_files = []
    failure_files = []

    params[:file_asset][:attachment].each do |file|
      filename = file.original_filename

      # "Overwrite" existing by removing them
      FileAsset.find_by_attachment_file_name(filename).try(:destroy)

      file_asset = FileAsset.new('attachment' => file)
      if file_asset.save!
        success_files << "“#{filename}”"
      else
        failure_files << "“#{filename}”"
      end
    end

    flash[:notice] = "File(s) #{success_files.join(', ')} were successfully uploaded." if success_files.any?
    flash[:errors] = "File(s) #{failure_files.join(', ')} were not uploaded."          if failure_files.any?

    cleanup_cached_pages
    redirect_to admin_file_assets_path
  end

  def destroy
    FileAsset.destroy(params[:id])
    redirect_to admin_file_assets_path
    cleanup_cached_pages
  end

  private

  def ensure_file_upload_array
    if !params[:file_asset][:attachment].is_a?(Array)
      params[:file_asset][:attachment] = [ params[:file_asset][:attachment] ]
    end
  end

  def cleanup_cached_pages
    cache_dir = ActionController::Base.page_cache_directory
    Page.all.each do |p|
      FileUtils.rm("#{cache_dir}/#{p.url}") if File.exist?("#{cache_dir}/#{p.url}")
    end
  end
end