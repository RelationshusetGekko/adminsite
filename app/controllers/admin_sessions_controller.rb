class AdminSessionsController < Devise::SessionsController
  skip_filter :verify_authenticity_token, only: [:destroy]

  layout 'admin'
end