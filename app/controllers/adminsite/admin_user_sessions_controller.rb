class Adminsite::AdminUserSessionsController < Devise::SessionsController
  skip_filter :verify_authenticity_token, only: [:destroy]

  layout 'adminsite/admin'

  def authorize_resource_class
    self
  end

end