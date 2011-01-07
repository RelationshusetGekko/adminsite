Rails.application.routes.draw do
  root  :to => 'contents#show', :page_url => 'index'
  match '/:page_url(.:format)(/:id)' => 'contents#show'
end