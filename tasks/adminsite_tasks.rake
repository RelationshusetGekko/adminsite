namespace :adminsite do  
  desc "Sync extra files from adminsite plugin"  
  task :sync do  
    system "rsync -ruv vendor/plugins/adminsite/db/migrate db"  
    system "rsync -ruv vendor/plugins/adminsite/public ."  
  end
  
  desc "Setup an admin account"
  task :setup => :environment do
    Admin.create!(:login                 => "admin",
                  :password              => "password",
                  :password_confirmation => "password")
    puts "Created admin account: admin/password"
  end
end