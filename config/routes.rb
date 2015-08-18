Adminsite::Engine.routes.draw do
  devise_for :adminsite_admin_user, class_name: 'Adminsite::AdminUser',
             :controllers => { :sessions => "adminsite/admin_user_sessions" }

  namespace Adminsite.config.admin_namespace, as: :admin, module: :admin do
    root      :to => 'adminsite_pages#index'
  end

  root  :to => 'contents#show', :page_url => 'index'

end
