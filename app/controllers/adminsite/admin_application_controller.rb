# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Adminsite::AdminApplicationController < ActionController::Base
  helper :all, "admin/adminsite_application"
  layout 'adminsite/admin'
  before_filter :authenticate_adminsite_admin_user!

end