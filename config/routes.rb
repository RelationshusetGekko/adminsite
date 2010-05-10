ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'admin_sessions' do |admin_sessions|
    admin_sessions.logout           '/logout',       :action => 'destroy'
    admin_sessions.login            '/login',        :action => 'new'
    admin_sessions.open_id_complete 'admin_session', :action => 'create',
                                                     :requirements => { :method => :get }
    admin_sessions.resource :admin_session, :only => [:new, :create, :destroy]
  end
  map.namespace :admin do |admin|
    admin.resources :admins, :except => :show
    admin.resources :file_assets
    admin.resources :page_layouts
    admin.resources :pages
    admin.resources :exports
    admin.resources :users
    admin.resources :statistics
  end
  map.resource :admin_session
  map.admin_login "/admin", :controller => "admin_sessions", :action => "new"
end
