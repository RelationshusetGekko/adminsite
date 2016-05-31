class Adminsite::Admin::ResourcesController < Adminsite::Admin::CrudController
  before_filter :find_resource, :except => [:new, :create, :index]

  helper_method :admin_resource_path, :resource_class_underscore,
                :resource_class, :resource_admin_config

  respond_to :html, :json


  def new
    @resource ||= self.class.resource_class.new
  end

  def create
    @resource ||= self.class.resource_class.new(resource_params)

    if @resource.save
      flash_notice_success('created')
      if api_call?
        render :json => @resource
      else
        redirect_to admin_resource_path(@resource.id)
      end
    else
      render :action => "new"
    end
  end

  def edit
  end

  def show
    render :json => @resource if api_call?
  end

  def update
    if @resource.update_attributes(resource_params)
      flash_notice_success('updated')
      if api_call?
        render :json => @resource
      else
        redirect_to admin_resource_path(@resource.id, :edit)
      end
    else
      render :action => "edit"
    end
  end

  def index
    @q = scope_resources.ransack(params[:q])
    @resources = @q.result.order(order_params).page(params[:page])
    @ransack_params = ransack_params
    @search_params  = @ransack_params[:q].try(:except, :s)
    @show_search_form = @search_params.present?
    render :json => @resources if api_call?
  end

  def destroy
    @resource.destroy
    redirect_to admin_resource_path
  end

  def resource_class
    self.class.resource_class
  end

  def authorize_resource_class
    resource_class
  end

  def resource_class_underscore
    @resource_class_underscore ||= resource_class.to_s.underscore.gsub('/','_')
  end

  def ransack_params
    params.slice(:q, :p).each{|k,v| v.delete_if {|key, value| value.blank? }}
  end

  def current_admin_menu
    @current_admin_menu ||= params[:admin_menu]
  end

  def admin_resource_path(id = nil, action = nil, options = {})
    path = self.class.remove_namespace(params[:controller], ['adminsite'])
    path = path.gsub('/','_')
    path = path.singularize if (action || id).present? && action.to_s != 'search'
    path = "#{action}_#{path}" if action.present?
    send("#{path}_path", id, {admin_menu: current_admin_menu}.merge(options) )
  end

  protected

  def resource_class_with_parent
    resource_class
  end

  def api_call?
    request.xhr? || request.format.to_sym == :json
  end

  def find_resource
    @resource ||= scope_resources.find(params[:id])
  end

  def scope_resources
     if filter_scopes.present?
      eval("resource_class.#{filter_scopes.join('.')}")
    else
      self.class.resource_class.all
    end
  end

  def resource_params
    permitted_params[resource_class_underscore]
  end

  def flash_notice_success(action)
    flash[:notice] = "#{resource_class.name} was successfully #{action}."
  end

  def filter_scopes
    @scopes ||= []
    return @scopes if params[:scope].blank?
    scopes = params[:scope].split(',').collect(&:to_sym)
    @scopes = resource_admin_config.scopes.collect(&:to_sym) & scopes
  end

  def order_params
    'ID DESC'
  end

  def resource_admin_config
    return @resource_admin_config if @resource_admin_config.present?
    @resource_admin_config = Adminsite::AdminConfig::Base.admin_config_of_class(resource_class, nil, current_adminsite_admin_user)
    @resource_admin_config
  end

  class << self

    def content_menu_label
      pattern = "^#{resource_class.to_s.deconstantize.split('::').join('|^')}"
      super.gsub(/#{pattern}/,'')
    end

    def remove_namespace(string, namespaces)
      (string.split('/') - namespaces).join('/')
    end

    def register_routes(rails_router)
      return if self == Adminsite::Admin::ResourcesController
      super(rails_router)
    end

    def resource_class
      raise NotImplementedError.new('Define resource_class in subclass')
    end
  end

end