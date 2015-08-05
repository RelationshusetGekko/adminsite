class Page < ActiveRecord::Base
  belongs_to :page_layout
  validates_presence_of :title
  validates_presence_of :page_layout
  validates_presence_of :url

  class << self

    def cache_dir
      @cache_dir ||= ActionController::Base.page_cache_directory
    end

    def cleanup_all_cached
      Page.all.each do |p|
        p.cleanup_cached
      end
      logger.info("Page cache has been wiped out: deleted all cached pages.")
    end

  end


  def cleanup_cached
    logger.info("Removing cached page at: #{cache_dir}/#{self.url}")
    FileUtils.rm("#{cache_dir}/#{self.url}") if File.exist?("#{cache_dir}/#{self.url}")
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
