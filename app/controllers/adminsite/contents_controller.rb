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

  def render_404
    page = find_page_by_url('404')
    if page.nil?
      render :file => Rails.root.join('public', '404.html'), :status => 404, layout: nil
    else
      render :text => page.render(liquid_attributes), :status => 404 and return
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

  def fallback_format
    'html'
  end

  def find_page_by_url(url)
    Adminsite::Page.find_by_url([url, "#{url}.#{fallback_format}"])
  end

  def liquid_attributes
    return @liquid_attributes if @liquid_attributes.present?

    @liquid_attributes = {}
    if defined?(liquid_params)
      @liquid_attributes = content_params.merge(liquid_params)
    else
      Rails.logger.warn("Please define liquid_params in your application controller")
    end
    Rails.logger.debug("Content params: #{@liquid_attributes.inspect}")
    @liquid_attributes
  end

  def retrive_page_or_404(url,id)
    page = find_page_by_url(url)
    unless page.nil?
      return if page.requires_login && !authenticate_content_user

      render :text => page.render(liquid_attributes)
      if page.cacheable?
        cache_page
        logger.info("Caching page: #{page.url}")
      else
        logger.info("Not caching page: #{page.url}")
      end
      return
    else
      render_404
    end
  end

end
