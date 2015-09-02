class Adminsite::Admin::BaseController < Adminsite::AdminApplicationController
  layout 'adminsite/admin'

  newrelic_ignore if defined?(NewRelic)

  def permitted_params
    params.permit!
  end

end
