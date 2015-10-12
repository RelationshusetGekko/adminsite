class Asset < Liquid::Tag
  def initialize(tag_name, asset_name, tokens)
    super
    @asset_name = asset_name.strip
  end

  def render(context)
    Adminsite::FileAsset.attachment_url_for(@asset_name)
  end
end

class Adminsite::LiquidTag < Liquid::Tag
  protected

  def controller
    Adminsite::ContentsController
  end

  def helpers
    @helpers ||= controller.helpers
  end
end

class CsrfMetaTags < Adminsite::LiquidTag
  include ActionView::Helpers::CsrfHelper
  include ActionView::Helpers::FormTagHelper

  def render(context)
    @environment = context.environments.first
    csrf_meta_tags
  end

  def protect_against_forgery?
    true
  end

  def form_authenticity_token
    @environment['authenticity_token']
  end

  def request_forgery_protection_token
    @environment['authenticity_param']
  end
end

class Adminsite::LiquidNameTag < Adminsite::LiquidTag
  def initialize(tag_name, name, tokens)
    super
    @name = name.strip
  end
end

class JavascriptIncludeTag < Adminsite::LiquidNameTag
  def render(context)
    helpers.javascript_include_tag @name
  end
end

class StylesheetLinkTag < Adminsite::LiquidNameTag
  def render(context)
    helpers.stylesheet_link_tag @name
  end
end

Liquid::Template.register_tag('asset', Asset)
Liquid::Template.register_tag('javascript_include_tag', JavascriptIncludeTag)
Liquid::Template.register_tag('stylesheet_link_tag', StylesheetLinkTag)
Liquid::Template.register_tag('csrf_meta_tags', CsrfMetaTags)