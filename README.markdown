Adminsite
=========
This is a basic Circle Admin Backend interface.

This support a series of namespaced (`yoursite.com/admin/`) backend with these
features:

- Login for admin
- Simple cms for pages (handle html xml files)
- Simple cms for file assets (handles images and swf files)
- Page caching
- Protected pages (agnostic, you need to implement your `current_user` methods)
- Mosso Cloud Files support
- Liquid template language

3 steps install
===============
1. Add this in your environment.rb:

    `config.gem 'adminsite'`

2. Run

    `./script/generate adminsite`

3. There is no 3  
You are ready to go!


How does it work.
================
1. Start your web server (ex: `./script/server`)
2. Log in at `http://localhost:3000/admin` with admin / password
3. Create a new page with:
   - name: index page
   - url:  index.html
   - body: "hello world"
4. open `http://localhost:3000/`

Mosso Cloud Files
=================
If you want to use Mosso Cloud Files support you should add a
`config/mosso_cloudfiles.yml` that should look like this:

    development:
      username: circlerd
      api_key: SECRET_API
    test:
      username: katherine
      api_key: test
    production:
      username: circlerd
      api_key: SECRET_API

`SECRET_API` is defined into the Mosso control panel and in all the projects we
have with Mosso integration (copy it from one of them).

Add this into your `config/environments/production.rb`:

    PAPERCLIP_CONTAINER = "my_project_container"

Be sure that `my_project_container` exists for your account.

Add this line into your `config/environment.rb`:

    gem.require 'cloudfiles'


Protected pages
===============
If you want protected pages you need to add in `ApplicationController` a
`require_user` method:

This method should return `false` if no user is logged in or `true` if there is
a user logged in

ex. using Authlogic:

    def require_user
      unless current_user
        flash[:notice] = "You must be logged in to access this page"
        redirect_to "/"
        return false
      end
      return true
    end
    
    def current_user
      # Place you authentication code here
    end


Rake Tasks
==========
The gem adds these task:

    rake adminsite:sync
    rake db:migrate
    rake adminsite:setup

These tasks are all executed for you by `script/generate adminsite`