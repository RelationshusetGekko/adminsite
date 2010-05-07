class Page < ActiveRecord::Base

  def render(liquid_params)
    template = Liquid::Template.parse(body_with_contents)
    template.render(liquid_params.stringify_keys)
  end

  def body_with_contents
    body.gsub(/(\{asset: ([\w.]+)\})/) do |s|
      url = $2
      file_asset = FileAsset.find_by_attachment_file_name(url)
      if file_asset.nil?
        "http://missing.jpg?#{url}"
      else
        file_asset.attachment.url(:original, false)
      end
    end
  end
end
