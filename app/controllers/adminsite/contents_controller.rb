class Adminsite::ContentsController < ApplicationController
  include ActionController::Caching::Pages
  self.page_cache_directory = Adminsite::Engine.config.action_controller.page_cache_directory

  before_filter :set_p3p

  def show
    respond_to do |format|
      format.html { retrive_page_or_404(params[:page_url],params[:id]) }
      format.css  { retrive_page_or_404("#{params[:page_url]}.css",params[:id])}
      format.xml  { retrive_page_or_404("#{params[:page_url]}.xml",params[:id])}
    end
  end

  private

  def set_p3p
    response.headers['P3P'] = 'CP="CAO PSA OUR"'
  end

  def content_params
    { :authenticity_token => form_authenticity_token,
      :notice => flash[:notice],
      :error  => flash[:error] }
  end

  def retrive_page_or_404(url,id)
    page = Adminsite::Page.find_by_url(url) || Adminsite::Page.find_by_url("#{url}.html")
    unless page.nil?
      if page.requires_login
        unless authenticate_content_user
          return
        end
      end

      liquid_attributes = {}
      begin
        liquid_attributes = content_params.merge(liquid_params)
      rescue NameError => e
        Rails.logger.warn("WARNING: #{e.message}")
        Rails.logger.warn("Please define liquid_params in your application controller")
      end
      Rails.logger.debug("Content params: #{liquid_attributes.inspect}")
      content = page.render(liquid_attributes)
      render :text => content
      if page.cacheable?
        cache_page
        logger.info("Caching page: #{page.url}")
      else
        logger.info("Not caching page: #{page.url}")
      end
      return
    else
      # find a custom 404 page in CMS
      Adminsite::Page.find_by_url('404')
      unless page.nil?
        render :text => page.body, :status => 404 and return
      end
    end
    render :file => Rails.root.join('public', '404.html'), :status => 404
  end

end
