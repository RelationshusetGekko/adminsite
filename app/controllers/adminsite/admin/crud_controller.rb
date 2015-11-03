class Adminsite::Admin::CrudController <  Adminsite::Admin::BaseController

  def index
    #
  end

  protected

  class << self

    def crud_default_controller_actions
      [:new, :create, :show, :edit, :update, :index, :destroy]
    end

    def defined_controller_actions
      crud_default_controller_actions.select{|a| new.respond_to?(a) }
    end

    def register_routes(rails_router)
      return if self == Adminsite::Admin::CrudController
      rails_router.instance_exec controller_name, defined_controller_actions do |controller_name, actions|
        resources controller_name, controller: controller_name, only: actions do
          yield(self) if block_given?
        end
      end
    end

  end

end


