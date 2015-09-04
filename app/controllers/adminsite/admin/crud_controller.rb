class Adminsite::Admin::CrudController <  Adminsite::Admin::BaseController

  def index
    #
  end

  protected

  class << self

    def defined_controller_actions
      [:new, :create, :show, :edit, :update, :index, :destroy].select{|a| new.respond_to?(a) }
    end

     def register_routes
       puts "#{self.name}.register_routes"
       eval( "Adminsite::Engine.routes.append do
         namespace :#{Adminsite.config.admin_namespace}, as: :admin, module: :admin do
           resources :#{controller_name}, controller: '#{controller_name}', only: #{defined_controller_actions.inspect} do
              collection { get :search, to: '#{controller_name}#index' }
            end
         end
       end" )
     end

  end

end


