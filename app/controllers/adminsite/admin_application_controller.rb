# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Adminsite::AdminApplicationController < ActionController::Base
  helper :all, "admin/adminsite_application"
  layout 'adminsite/admin'

  before_filter :authenticate_adminsite_admin_user!

  include ::CanCan::ControllerAdditions
  authorize_resource class: :resource_class
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render text: exception.message
  end

  protected

  def resource_class
    self
  end

  def current_ability
    @current_ability ||= ::Adminsite::Ability.new(current_adminsite_admin_user)
  end

end