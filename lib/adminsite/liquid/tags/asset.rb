class Asset < Liquid::Tag
  def initialize(tag_name, asset_name, tokens)
    super
    @asset_name = asset_name.strip
  end

  def render(context)
    Adminsite::FileAsset.attachment_url_for(@asset_name)
  end
end

class JavascriptIncludeTag < Liquid::Tag
  def initialize(tag_name, javascript, tokens)
    super
    @javascript = javascript.strip
  end

  def render(context)
    ActionController::Base.helpers.javascript_include_tag @javascript
  end
end

class StylesheetLinkTag < Liquid::Tag
  def initialize(tag_name, stylesheet, tokens)
    super
    @stylesheet = stylesheet.strip
  end

  def render(context)
    ActionController::Base.helpers.stylesheet_link_tag @stylesheet
  end
end

Liquid::Template.register_tag('asset', Asset)
Liquid::Template.register_tag('javascript_include_tag', JavascriptIncludeTag)
Liquid::Template.register_tag('stylesheet_link_tag', StylesheetLinkTag)
