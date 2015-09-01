class Adminsite::Admin::IndexController <  Adminsite::Admin::BaseController

  def index
    #
  end


  class << self

     def register_routes
       puts "#{self.name}.register_routes"
       eval( "Adminsite::Engine.routes.append do
         namespace :#{Adminsite.config.admin_namespace}, as: :admin, module: :admin do
           match :#{controller_name}, to: '#{controller_name}#index', via: [:get]
         end
       end" )
     end

  end

end


