class Adminsite::Admin::ResourcesController < Adminsite::Admin::BaseController
  before_filter :find_resource, :except => [:new, :create, :index]

  helper_method :admin_resource_path, :resource_class_underscore,
                :resource_class, :resource_admin_config , :resource_entity_name

  def new
    @resource ||= self.class.resource_class.new
  end

  def create
    @resource ||= self.class.resource_class.new(resource_params)
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

  def resource_class
    self.class.resource_class
  end

  def resource_entity_name
    self.class.resource_entity_name
  end

  def resource_class_underscore
    @resource_class_underscore ||= self.class.remove_namespace(resource_class.to_s.underscore, ['adminsite'])
  end

  def admin_resource_path(id = nil, action = nil)
    # admin_adminsite_pages_path
    # <action>_admin_adminsite_page_path
    path = self.class.remove_namespace(params[:controller], ['adminsite'])
    path = path.gsub('/','_')
    path = path.singularize if (action || id).present?
    path = "#{action}_#{path}" if action.present?
    send("#{path}_path", id)
  end

  protected

  def find_resource
    @resource ||= resources.find(params[:id])
  end

  def resources
    if filter_scopes.any?
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
    []
  end

  def order_params
    'ID DESC'
  end

  def resource_admin_config
    return @resource_admin_config if @resource_admin_config.present?
    @resource_admin_config = Adminsite::AdminConfig::Base.admin_config_of_class(resource_class)
    @resource_admin_config
  end


  class << self

    def routing_controller_declaration
      declaration = remove_namespace(self.name.underscore, ['adminsite'])
      declaration.gsub('_controller','')
    end

    def remove_namespace(string, namespaces)
      (string.split('/') - namespaces).join('/')
    end

    def resource_entity_name
      resource_class.name.underscore.gsub('/','_')
    end

    def register_routes
      puts "#{self.name}.register_routes"
      eval( "Adminsite::Engine.routes.append do
        namespace :#{Adminsite.config.admin_namespace}, as: :admin, module: :admin do
          resources :#{resource_entity_name}s, class_name: #{resource_class} # , controller: '#{routing_controller_declaration}'
        end
      end" )
    end

    def resource_class
      raise NotImplementedError.new('Define resource_class in subclass')
    end
  end

end