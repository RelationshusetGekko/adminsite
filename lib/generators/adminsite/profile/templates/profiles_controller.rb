class Admin::ProfilesController < AdminApplicationController

  def index
    @profiles = Profile.order('created_at DESC')
    @profiles = @profiles.containing_text(params[:query]) if params[:query].present?
    @profiles = @profiles.paginate(:page => params[:page], :per_page => 50)

    if request.xml_http_request?
      render :partial => "profile_list", :layout => false
    end
  end

  def show
    @attr_lst = ( Profile.column_names - %w[id password_hash password_salt] + %w[password_present?] ).sort
    @profile = Profile.find(params[:id])
  end
end