# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Adminsite::AdminApplicationController < ActionController::Base
  include ::CanCan::ControllerAdditions
  helper :all, "admin/adminsite_application"
  layout 'adminsite/admin'
  before_filter :authenticate_adminsite_admin_user!
  authorize_resource
  # check_authorization

  protected

  def current_ability
    @current_ability ||= ::Adminsite::Ability.new(current_adminsite_admin_user)
  end

end