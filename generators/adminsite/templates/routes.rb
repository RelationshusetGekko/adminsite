ActionController::Routing::Routes.draw do |map|
  map.root    :controller => 'contents', :action => 'show', :page_url => 'index'
  map.connect ':page_url', :controller => 'contents', :action => 'show'
  map.connect ':page_url.:format', :controller => 'contents', :action => 'show'
  map.connect ':page_url/:id', :controller => 'contents', :action => 'show'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end