class AdminsiteProfileGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def run_generation
    puts "Setting up Adminsite profiles"
    # Migration
    template  "20110428113548_create_profiles.rb", "db/migrate/20110428113548_create_profiles.rb.rb"
    # Model
    template  "profile.rb"                       , "app/models/profile.rb"
    # Controller
    template  "profiles_controller.rb"           , "app/controllers/admin/profiles_controller.rb"
    # Views
    template  "profiles/index.html.haml"         , "app/views/admin/profiles/index.html.haml"
    template  "profiles/show.html.haml"          , "app/views/admin/profiles/show.html.haml"
    template  "profiles/_profile_list.html.haml" , "app/views/admin/profiles/_profile_list.html.haml"
    # Lib
    template  "lib/postal_login_code_generator.rb", "lib/postal_login_code_generator.rb"

    # Routes
    inject_into_file "config/routes.rb", :after => /\.routes\.draw do\s*\n/ do
      "  namespace :admin do\n    resources :profiles\n  end\n"
    end

    # _Menu
    inject_into_file "app/views/admin/shared/_menu.haml", :before => /^.*destroy_admin_session_path/ do
      "    = menu_item 'Profiles', admin_profiles_path, 'profiles'\n"
    end

    # Gemfile
    inject_into_file "Gemfile", :before => /^.*gem 'adminsite'/ do
      "gem 'validates_email_format_of', :git => 'git://github.com/alexdunae/validates_email_format_of.git'\n"+
      "gem 'will_paginate', '~>3.0.pre2'\n"
    end

    # Javascript
    inject_into_file "public/javascripts/application.js" do
      <<-DELAYED_OBSERVER.strip_heredoc
      /*
       jQuery delayed observer
       (c) 2007 - Maxime Haineault (max@centdessin.com)
      */
      jQuery.fn.extend({
        delayedObserver:function(delay, callback){
          $this = $(this);
          if (typeof window.delayedObserverStack == 'undefined') {
            window.delayedObserverStack = [];
          }
          if (typeof window.delayedObserverCallback == 'undefined') {
            window.delayedObserverCallback = function(stackPos) {
              observed = window.delayedObserverStack[stackPos];
              if (observed.timer) clearTimeout(observed.timer);

              observed.timer = setTimeout(function(){
                observed.timer = null;
                observed.callback(observed.obj.val(), observed.obj);
              }, observed.delay * 1000);

              observed.oldVal = observed.obj.val();
            }
          }
          window.delayedObserverStack.push({
            obj: $this, timer: null, delay: delay,
            oldVal: $this.val(), callback: callback });

            stackPos = window.delayedObserverStack.length-1;

          $this.keyup(function() {
            observed = window.delayedObserverStack[stackPos];
              if (observed.obj.val() == observed.obj.oldVal) return;
              else window.delayedObserverCallback(stackPos);
          });
        }
      });
      DELAYED_OBSERVER
    end
  end

  def after_generate
    puts "Adminsite profiles - DONE"
  end
end