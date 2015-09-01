class Adminsite::Admin::IframeController <  Adminsite::Admin::CrudController

  def index
    @iframe_name = self.class.iframe_name
    @iframe_url  = self.class.iframe_url
  end


  class << self

    def iframe_name
      raise NotImplementedError.new('Define iframe_name in subclass')
    end

    def iframe_url
      raise NotImplementedError.new('Define iframe_url in subclass')
    end

  end

end

