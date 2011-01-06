Rails.application.routes.draw do

  namespace :admin do
    resources :admins, :except => :show
    resources :file_assets
    resources :page_layouts
    resources :pages
    resources :exports
    resources :users
    resources :statistics
  end

  match '/logout' => 'admin_sessions#destroy', :as => 'logout'
  match '/admin' => 'admin_sessions#new', :as => 'admin_login'
  resource :admin_session

  root  :to => 'contents#show', :page_url => 'index'
  match '/:page_url(.:format)(/:id)' => 'contents#show'
end
