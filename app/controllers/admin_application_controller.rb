# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class AdminApplicationController < ActionController::Base
  unloadable
  helper :all, "admin/adminsite_application"
  layout 'admin'
  before_filter :authenticate_admin!
end
