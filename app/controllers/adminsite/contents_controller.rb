class Adminsite::ContentsController < ApplicationController
  include ActionController::Caching::Pages
  self.page_cache_directory = Adminsite::Engine.config.action_controller.page_cache_directory

  before_filter :set_p3p

  def show
    retrive_page_or_404(params[:page_url], params[:id], params[:format])
  end

  def render_404(format = params[:format])
    page = find_page_by_url('404', format)
    if page.nil?
      render :file => Rails.root.join('public', '404.html'), :status => 404, layout: nil
    else
      render :text => page.render(liquid_attributes), :status => 404 and return
    end
  end

  class << self

    def fallback_format
      'html'
    end

    def find_page_by_url(url, format)
      urls = ["#{url}.#{format || fallback_format}" ]
      urls.unshift(url) if format.nil?
      urls.push(url) if format == 'html'
      Adminsite::Page.find_by_url(urls[0]) || (urls[1].present? && Adminsite::Page.find_by_url(urls[1]))
    end
  end

  private

  def find_page_by_url(url, format)
    self.class.find_page_by_url(url, format)
  end

  def set_p3p
    response.headers['P3P'] = 'CP="CAO PSA OUR"'
  end

  def content_params
    { :authenticity_token => form_authenticity_token,
      :authenticity_param => request_forgery_protection_token,
      :notice => flash[:notice],
      :error  => flash[:error]
    }
  end

  def liquid_attributes
    return @liquid_attributes if @liquid_attributes.present?

    @liquid_attributes = {}
    if defined?(liquid_params)
      @liquid_attributes = content_params.merge(liquid_params)
    else
      @liquid_attributes = content_params
      Rails.logger.warn("Please define liquid_params in your application controller")
    end
    Rails.logger.debug("Content params: #{@liquid_attributes.inspect}")
    @liquid_attributes
  end

  def retrive_page_or_404(url, id, format)
    page = find_page_by_url(url, format)
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
      render_404(format)
    end
  end

end
