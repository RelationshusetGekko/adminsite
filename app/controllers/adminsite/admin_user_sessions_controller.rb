class Adminsite::AdminUserSessionsController < Devise::SessionsController
  skip_filter :verify_authenticity_token, only: [:destroy]

  layout 'adminsite/admin'

  def authorize_resource_class
    self
  end

  def after_sign_out_path_for(resource_or_scope)
    new_adminsite_admin_user_session_path
  end

end