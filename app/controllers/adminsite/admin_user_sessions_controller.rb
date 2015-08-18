class Adminsite::AdminUserSessionsController < Devise::SessionsController
  skip_filter :verify_authenticity_token, only: [:destroy]

  layout 'adminsite/admin'
end