class Admin::ProfilesController < AdminApplicationController

  def index
    @profiles = Profile.containing_text(params[:query]).paginate(:page => params[:page] || 1, :order => 'created_at DESC', :per_page => 50)

    if request.xml_http_request?
      render :partial => "profile_list", :layout => false
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end
end