class Admin::ResourcesController < Admin::BaseController
  before_filter :find_resource, :except => [:new, :create, :index]

  helper_method :admin_resource_path, :resource_class_underscore,
                :resource_class, :resource_admin_config

  def new
    @resource ||= resource_class.new
  end

  def create
    @resource ||= resource_class.new(resource_params)
    if @resource.save
      flash_notice_success('created')
      redirect_to admin_resource_path(@resource.id)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @resource.update_attributes(resource_params)
      flash_notice_success('updated')
      redirect_to admin_resource_path(@resource.id, :edit)
    else
      render :action => "edit"
    end
  end

  def index
    @resources = resources.order(order_params)
  end

  def destroy
    @resource.destroy
    redirect_to admin_resource_path
  end

  def resource_class_underscore
    @resource_class_underscore ||= resource_class.to_s.underscore
  end

  def admin_resource_path(id = nil, action = nil)
    path = "/#{params[:controller]}"
    path = "#{path}/#{id}" if id.present?
    path = "#{path}/#{action}" if action.present?
    path
  end

  private

  def resources
    if filter_scopes.any?
      eval("resource_class.#{filter_scopes.join('.')}")
    else
      resource_class.all
    end
  end

  def filter_scopes
    []
  end

  def order_params
    'ID DESC'
  end

  def find_resource
    @resource ||= resources.find(params[:id])
  end

  def flash_notice_success(action)
    flash[:notice] = "#{resource_class.name} was successfully #{action}."
  end

  def resource_params
    permitted_params[resource_class_underscore]
  end

  def resource_class
    raise NotImplementedError.new('Define resource_class in subclass')
  end

  def resource_admin_config
    eval  "Adminsite::#{resource_class}::AdminConfig"
  end

end