class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string   :login, :default => nil, :null => true
      t.string   :crypted_password, :default => nil, :null => true
      t.string   :password_salt, :default => nil, :null => true
      t.string   :persistence_token, :null => false
      t.integer  :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
      t.string   :openid_identifier
      
      t.timestamps
    end
    
    add_index :admins, :openid_identifier
    add_index :admins, :login
    add_index :admins, :persistence_token
    add_index :admins, :last_request_at
  end

  def self.down
    drop_table :admins
  end
end
