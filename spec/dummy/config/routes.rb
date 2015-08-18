Rails.application.routes.draw do

  mount ::Adminsite::Engine => "/"

  namespace :admin do
    resources :tests
  end

end
