class Admin::FileAssetsController < Admin::BaseController
  def index
    @file_assets = FileAsset.all
    @file_asset = FileAsset.new
  end

  def create
    filename = params[:file_asset]["attachment"].original_filename
    if existing_files = FileAsset.find_by_attachment_file_name(filename)
      # "Overwrite" existing by removing them
      existing_files.destroy
    end 
    
    @file_asset = FileAsset.new(params[:file_asset])
    if @file_asset.save!
      flash[:notice] = 'File was successfully uploaded.'
    else
      flash[:error] = 'File was not uploaded.'
    end
    cleanup_cached_pages
    redirect_to admin_file_assets_path
  end

  def destroy
    FileAsset.destroy(params[:id])
    redirect_to admin_file_assets_path
    cleanup_cached_pages
  end
  
  private
  def cleanup_cached_pages
    cache_dir = ActionController::Base.page_cache_directory
    Page.all.each do |p|
      FileUtils.rm("#{cache_dir}/#{p.url}") if File.exist?("#{cache_dir}/#{p.url}")
    end
  end
end