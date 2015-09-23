class Adminsite::Admin::CrudController <  Adminsite::Admin::BaseController

  def index
    #
  end

  protected

  class << self

    def defined_controller_actions
      [:new, :create, :show, :edit, :update, :index, :destroy].select{|a| new.respond_to?(a) }
    end

    def register_routes(rails_router)
      return if self == Adminsite::Admin::CrudController
      puts "#{self.name}.register_routes"

      rails_router.instance_exec controller_name, defined_controller_actions do |controller_name, actions|
        resources controller_name, controller: controller_name, only: actions do
        end
      end
    end

  end

end


