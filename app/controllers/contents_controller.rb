class ContentsController < ApplicationController
  before_filter :set_p3p
  caches_page :show
  
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
  
  def retrive_page_or_404(url,id)
    page = Page.find_by_url(url) || Page.find_by_url("#{url}.html")
    unless page.nil?
      content = page.body_with_contents
      render :text => content
      return
    else
      # find a custom 404 page in CMS
      Page.find_by_url('404')
      unless page.nil?
        render :text => page.body, :status => 404 and return
      end
    end
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
end