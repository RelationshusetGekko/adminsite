namespace :adminsite do  
  desc "Sync extra files from adminsite plugin"  
  task :sync do  
    migrate_dir = File.dirname(__FILE__) + "/../../db/migrate"
    public_dir = File.dirname(__FILE__) + "/../../public"
    system "rsync -ruv #{migrate_dir} db"  
    system "rsync -ruv #{public_dir} ."  
  end

  desc "Setup an admin account"
  login = "admin"
  if Rails.env.development?
    password = "password"
  else
    password = Digest::MD5.hexdigest(Time.now.to_s)[0..5]
  end
  
  task :setup => :environment do
    Admin.create!(:login                 => login,
                  :password              => password,
                  :password_confirmation => password)
    puts "Created administrator with login: #{login} and password: #{password}"
  end
end