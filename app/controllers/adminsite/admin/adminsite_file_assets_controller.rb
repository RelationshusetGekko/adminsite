# encoding: utf-8

class Adminsite::Admin::AdminsiteFileAssetsController < Adminsite::Admin::BaseController

  def index
    @file_assets = Adminsite::FileAsset.all.order('attachment_file_name ASC')
    @file_asset = Adminsite::FileAsset.new
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
    Adminsite::FileAsset.destroy(params[:id])
    redirect_to admin_adminsite_file_assets_path
    Adminsite::Page.cleanup_all_cached
  end

  private

end