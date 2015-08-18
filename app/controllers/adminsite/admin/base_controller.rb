class Adminsite::Admin::BaseController < Adminsite::AdminApplicationController
  layout 'adminsite/admin'

  def permitted_params
    params.permit!
  end

end
