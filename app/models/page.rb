class Page < ActiveRecord::Base
  belongs_to :page_layout
  validates_presence_of :page_layout
  
  class << self
    def cleanup_all_cached
      cache_dir = ActionController::Base.page_cache_directory
      Page.all.each do |p|
        FileUtils.rm("#{cache_dir}/#{p.url}") if File.exist?("#{cache_dir}/#{p.url}")
      end
      logger.info("Page cache has been wiped out: deleted all cached pages.")
    end
  end
  
  def render(args)
    page_layout.render(layout_args(args))
  end

  def layout_args(args)
    args.stringify_keys.merge(:content_for_template => content_for_template(args))
  end

  def content_for_template(liquid_params)
    liquid_template = Liquid::Template.parse(body_with_contents)
    liquid_template.render(liquid_params.stringify_keys)
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
