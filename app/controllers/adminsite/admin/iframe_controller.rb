class Adminsite::Admin::IframeController <  Adminsite::Admin::BaseController

  def index
    @iframe_name = self.class.iframe_name
    @iframe_url  = self.class.iframe_url
  end


  class << self

   def iframe_name
     raise NotImplementedError.new('Define iframe_name in subclass')
   end

   def iframe_url
     raise NotImplementedError.new('Define iframe_url in subclass')
   end

    def register_routes
      puts "#{self.name}.register_routes"
      eval( "Adminsite::Engine.routes.append do
        namespace :#{Adminsite.config.admin_namespace}, as: :admin, module: :admin do
          # GooglesController.register_routes  .. admin_google_path
          match :#{iframe_name}, to: '#{iframe_name}#index', via: [:get]
        end
      end" )
    end

  end

end


