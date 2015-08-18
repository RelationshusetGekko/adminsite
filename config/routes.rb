Rails.application.routes.draw do
end

Adminsite::Engine.routes.draw do
  devise_for :adminsite_admin_user, class_name: 'Adminsite::AdminUser',
             :controllers => { :sessions => "adminsite/admin_user_sessions" }

  namespace :admin do
    resources :adminsite_admin_users , except: :show, class_name: 'Adminsite::AdminUser'
    resources :adminsite_file_assets , class_name: 'Adminsite::FileAssets'
    resources :adminsite_page_layouts , class_name: 'Adminsite::PageLayout'
    resources :adminsite_pages , class_name: 'Adminsite::Page'
    root      :to => 'adminsite_pages#index'
  end

  root  :to => 'contents#show', :page_url => 'index'
  get '/:page_url(.:format)(/:id)' => 'contents#show'
end
