if Rails.env.development?
  require 'rails-footnotes'

  Footnotes.setup do |config|
    config.before do |controller, filter|
      filter.prefix = 'http://localhost:3000/_xray/open?path=%s&line=%d&column=%d'
    end
  end

  Footnotes.run!
end
