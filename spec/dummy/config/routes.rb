Rails.application.routes.draw do

  mount ::Adminsite::Engine => '/'
  get '/:page_url(.:format)(/:id)' => 'adminsite/contents#show'

end
