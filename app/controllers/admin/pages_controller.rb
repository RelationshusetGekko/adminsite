class Admin::PagesController < Admin::BaseController

  def index
    @pages = Page.all.order("title ASC")
  end

  def new
    @page = Page.new
    @file_assets = FileAsset.all
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
    @file_assets = FileAsset.all
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      @page.cleanup_cached
      redirect_to(edit_admin_page_path(@page))
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.cleanup_cached
    @page.destroy
    redirect_to(admin_pages_path)
  end

  private
end