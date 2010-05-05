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
    Admin.create!(:login                 => "admin",
                  :password              => "password",
                  :password_confirmation => "password")
  end
end