class Admin::PagesController < Admin::BaseController
  layout 'admin'
  def index
    @pages = Page.find(:all, :order => "title ASC")
  end
  
  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
    @file_assets = FileAsset.all
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect_to(admin_pages_path)
    else
      render :action => "new"
    end
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      cleanup_cached_page(@page.url)
      redirect_to(edit_admin_page_path(@page))
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    cleanup_cached_page(@page.url)
    @page.destroy
    redirect_to(admin_pages_path)
  end
  
  private
  def cleanup_cached_page(file_name)
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm("#{cache_dir}/#{file_name}") if File.exist?("#{cache_dir}/#{file_name}")
  end
end