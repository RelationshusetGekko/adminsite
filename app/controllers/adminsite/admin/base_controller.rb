class Adminsite::Admin::BaseController < Adminsite::AdminApplicationController
  layout 'adminsite/admin'

  newrelic_ignore if defined?(NewRelic)

  protected

  def self.content_menu_label
    name.demodulize.sub(/Controller$/, '')
  end

  def permitted_params
    params.permit!
  end

end
