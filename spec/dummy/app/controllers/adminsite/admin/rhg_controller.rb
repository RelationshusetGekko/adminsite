class Adminsite::Admin::RhgController < Adminsite::Admin::IframeController

  private

  class << self

    def iframe_url
      'http://www.rhg.dk'
    end

    def iframe_name
      'rhg'
    end
  end

end