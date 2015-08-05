class Admin::BaseController < AdminApplicationController
  layout 'admin'

  def permitted_params
    params.permit!
  end

end
