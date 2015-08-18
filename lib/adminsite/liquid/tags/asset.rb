class Asset < Liquid::Tag
  def initialize(tag_name, asset_name, tokens)
    super
    @asset_name = asset_name.strip
  end

  def render(context)
    Adminsite::FileAsset.attachment_url_for(@asset_name)
  end
end

Liquid::Template.register_tag('asset', Asset)
