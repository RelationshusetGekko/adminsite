Adminsite
=========
This is a basic Admin Backend interface.

This support a series of namespaced (`yoursite.com/admin/`) backend with these
features:

- Login for admin
- Simple cms for pages (handle html xml files)
- Simple cms for file assets (handles images and swf files)
- Page caching
- Protected pages (agnostic, you need to implement your `authenticate_content_user` methods)
- Liquid template language

3 steps install
===============
1. Add this in your Gemfile:

    gem 'adminsite'

2. Run

    rails generate adminsite:install

3. There is no 3
You are ready to go!


How does it work.
================
1. Start your web server (ex: `rails s`)
2. Log in at `http://localhost:3000/admin` with admin / password
3. Create a new page with:
   - name: index page
   - url:  index.html
   - body: "hello world"
4. open `http://localhost:3000/`

CDN Support
============
use 'fog' with paperclip (http://fog.io, https://github.com/thoughtbot/paperclip#storage)

Protected pages
===============
If you want protected pages you need to add in `ApplicationController` a
`authenticate_content_user` method:

This method should return `false` if no user is logged in or `true` if there is
a user logged in

ex. using Devise:

    def authenticate_content_user
      unless current_user
        flash[:notice] = "You must be logged in to access this page"
        redirect_to "/"
        return false
      end
      return true
    end


Rake Tasks
==========
The gem adds these task:

    rake db:migrate

    rake adminsite:create_admin

    rake adminsite:seed:assets:clear
    rake adminsite:seed:assets:dump
    rake adminsite:seed:assets:load
    rake adminsite:seed:assets:reload

    rake adminsite:seed:page_layouts:clear
    rake adminsite:seed:page_layouts:dump
    rake adminsite:seed:page_layouts:load
    rake adminsite:seed:page_layouts:reload

    rake adminsite:seed:pages:clear
    rake adminsite:seed:pages:dump
    rake adminsite:seed:pages:load
    rake adminsite:seed:pages:reload

These tasks are all executed for you by `rails g | grep adminsite`
