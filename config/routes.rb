Rails.application.routes.draw do
  devise_for :admin,
             :controllers => { :sessions => "admin_sessions" }

  namespace :admin do
    resources :admins, :except => :show
    resources :file_assets
    resources :page_layouts
    resources :pages
    resources :exports
    resources :users
    resources :statistics
    root      :to => 'pages#index'
  end

  root  :to => 'contents#show', :page_url => 'index'
  get '/:page_url(.:format)(/:id)' => 'contents#show'
end
