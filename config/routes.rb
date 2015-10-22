Adminsite::Engine.routes.draw do
  devise_for :adminsite_admin_user, class_name: 'Adminsite::AdminUser',
             :controllers => { :sessions => "adminsite/admin_user_sessions" }

  namespace Adminsite.config.admin_namespace, as: :admin, module: :admin do
    Adminsite.register_routes(self)

    root      :to => 'adminsite_pages#index'
  end

  get '/:page_url(.:format)(/:id)' => 'contents#show',
      :constraints => lambda { |req|
                                Adminsite::ContentsController.find_page_by_url(req.params[:page_url], req.params[:format]).present? &&
                                 ( req.params[:id].nil? || req.params[:id].try(:match, /\A[0-9a-zA-Z]*\z/).present? )
                              }

end
