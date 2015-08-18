class Adminsite::PageLayout < ActiveRecord::Base
  has_many :pages
  validates_presence_of  :title

  def render(args)
    Liquid::Template.parse(self.body.to_s).render(args.stringify_keys)
  end

end
