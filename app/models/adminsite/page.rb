class Adminsite::Page < ActiveRecord::Base
  belongs_to :page_layout
  validates_presence_of :title
  validates_presence_of :page_layout
  validates_presence_of :url

  class << self

    def cleanup_all_cached
      Adminsite::Page.all.each do |p|
        p.cleanup_cached
      end
      logger.info("Page cache has been wiped out: deleted all cached pages.")
    end

    def cacheable
      where(cacheable: true)
    end

    def requires_login
      where(requires_login: true)
    end

  end

  def cache_dir
    @cache_dir ||= Adminsite::ContentsController.page_cache_directory # Adminsite::Engine.config.action_controller.page_cache_directory
  end

  def cleanup_cached
    return if self.url.blank?
    logger.info("Removing cached page for: #{self.url}")
    cache_file_path = "#{cache_dir}/#{self.url}"
    if !remove_cache_file(cache_file_path)
      remove_cache_file("#{cache_file_path}.html")
    end
  end

  def remove_cache_file(file_path)
    if File.exist?(file_path)
      logger.info("Removing cached page at: #{file_path}")
      FileUtils.rm(file_path)
      true
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
