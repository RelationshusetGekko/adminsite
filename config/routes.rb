Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    resources :admins, :except => :show
    resources :file_assets
    resources :page_layouts
    resources :pages
    resources :exports
    resources :users
    resources :statistics
  end

  root  :to => 'contents#show', :page_url => 'index'
  match '/:page_url(.:format)(/:id)' => 'contents#show'
end
