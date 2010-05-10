class Admin::PageLayoutsController < Admin::BaseController
  unloadable
  layout 'admin'
  def index
    @page_layouts = PageLayout.find(:all, :order => "title ASC")
  end
  
  def new
    @page_layout = PageLayout.new
  end
  
  def edit
    @page_layout = PageLayout.find(params[:id])
  end
  
  def create
    @page_layout = PageLayout.new(params[:page_layout])
    if @page_layout.save
      flash[:notice] = 'Page Layout was successfully created.'
      redirect_to(admin_page_layouts_path)
    else
      render :action => "new"
    end
  end
  
  def update
    @page_layout = PageLayout.find(params[:id])
    if @page_layout.update_attributes(params[:page_layout])
      flash[:notice] = 'Page Layout was successfully updated.'
      Page.cleanup_all_cached
      redirect_to(edit_admin_page_layout_path(@page_layout))
    else
      render :action => "edit"
    end
  end

  def destroy
    @page_layout = PageLayout.find(params[:id])
    Page.cleanup_all_cached
    @page_layout.destroy
    redirect_to(admin_page_layouts_path)
  end
end