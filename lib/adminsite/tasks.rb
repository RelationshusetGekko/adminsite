namespace :adminsite do
  desc "Sync extra files from adminsite plugin"
  task :sync do
    migrate_dir = File.dirname(__FILE__) + "/../../db/migrate"
    public_dir = File.dirname(__FILE__) + "/../../public"
    system "rsync -ruv #{migrate_dir} db"
    system "rsync -ruv #{public_dir} ."
  end

  desc "Setup an admin account"
  task :setup => :environment do

    email = "admin@crd.dk"
    if Rails.env.development?
      password = "password"
    else
      password = Digest::MD5.hexdigest(Time.now.to_s)[0..5]
    end

    Admin.create!(:email                 => email,
                  :password              => password,
                  :password_confirmation => password)
    puts "#{'*'*70}"
    puts "Done! You can access the admin interface at http://yourapp_url/admin"
    puts "I have created an administrator with these credentials:"
    puts "e-mail:   #{email}"
    puts "password: #{password}"
    puts ""
    puts "For Mosso Cloud Files integration and Protected pages"
    puts "please refer to the README file in this gem root folder"
    puts "#{'*'*70}"
  end
end