class Admin::AdminsController < Admin::BaseController
  protect_from_forgery :except => :update

  def index
    @admins = Admin.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @admins }
    end
  end

  def new
    @admin = Admin.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @admin }
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(permitted_params[:admin])
    respond_to do |format|
      if @admin.save
        flash[:notice] = 'Admin was successfully created.'
        format.html { redirect_to(edit_admin_admin_path(@admin)) }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(permitted_params[:admin])
        flash[:notice] = 'Admin was successfully updated.'
        format.html { redirect_to(admin_admins_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to(admin_admins_path) }
      format.xml  { head :ok }
    end
  end
end
