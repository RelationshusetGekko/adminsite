class Admin::ResourceController < Admin::BaseController

  helper_method :admin_resource_path, :resource_class_underscore

  def new
    @resource = resource_class.new
  end

  def create
    @resource = resource_class.new(resource_params)
    if @resource.save
      flash_notice_success
      redirect_to admin_resource_path(@resource)
    else
      render :action => "new"
    end
  end

  def edit
    @resource = resource_class.find(params[:id])
  end

  def update
    @resource = resource_class.find(params[:id])
    if @resource.update_attributes(resource_params)
      flash_notice_success
      redirect_to admin_resource_path(@resource, :edit)
    else
      render :action => "edit"
    end
  end

  def index
    @resources = resource_class.all
  end

  def destroy
    @resource = resource_class.find(params[:id])
    @resource.destroy
    redirect_to admin_resource_path
  end

  def resource_class_underscore
    @resource_class_underscore ||= resource_class.to_s.underscore
  end

  def admin_resource_path(id = nil, action = nil)
    path = "#{admin_root_path}/#{resource_class.table_name}"
    if id.present?
      if action.present?
        "#{path}/#{id}/#{action}"
      else
        "#{path}/#{id}"
      end
    else
      path
    end
  end

  private

  def flash_notice_success
    flash[:notice] = "#{resource_class.name} was successfully created."
  end

  def resource_params
    permitted_params[resource_class_underscore]
  end

  def resource_class
    raise NotImplementedError.new('Define resource_class in subclass')
  end

end