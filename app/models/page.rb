class Page < ActiveRecord::Base
  belongs_to :page_layout
  validates_presence_of :title
  validates_presence_of :page_layout
  validates_presence_of :url
  
  class << self
    def cleanup_all_cached
      cache_dir = ActionController::Base.page_cache_directory
      Page.all.each do |p|
        logger.info("Removing cached page at: #{cache_dir}/#{p.url}")
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
    liquid_template = Liquid::Template.parse(body)
    liquid_template.render(liquid_params.stringify_keys)
  end
end
