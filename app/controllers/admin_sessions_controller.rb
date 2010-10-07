class AdminSessionsController < AdminApplicationController
  unloadable
  before_filter :require_no_admin, :only => [:new, :create]
  before_filter :require_admin, :only => :destroy
  layout 'admin'
  def new
    @admin_session = AdminSession.new
  end

  def create
    @admin_session = AdminSession.new(params[:admin_session])
    @admin_session.save do |result|
      if result
        flash[:notice] = "Login successful!"
        redirect_back_or_default '/admin/admins'
      else
        note_failed_signin
        render :action => :new
      end
    end
  end

  def destroy
    current_admin_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_admin_session_url
  end

  private
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:admin_session][:login]}'"
    logger.warn "Failed login for '#{params[:admin_session][:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
