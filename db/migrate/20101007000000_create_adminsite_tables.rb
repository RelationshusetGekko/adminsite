class CreateAdminsiteTables < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string   :login,             :default => nil, :null => true
      t.string   :crypted_password,  :default => nil, :null => true
      t.string   :password_salt,     :default => nil, :null => true
      t.string   :persistence_token,                  :null => false
      t.integer  :login_count,       :default => 0,   :null => false
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

    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end
    add_index :sessions, :session_id
    add_index :sessions, :updated_at

    create_table :open_id_authentication_associations, :force => true do |t|
      t.integer :issued, :lifetime
      t.string :handle, :assoc_type
      t.binary :server_url, :secret
    end

    create_table :open_id_authentication_nonces, :force => true do |t|
      t.integer :timestamp, :null => false
      t.string :server_url, :null => true
      t.string :salt,       :null => false
    end

    create_table :file_assets do |t|
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.integer  :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end

    create_table :pages do |t|
      t.string :title
      t.string :url
      t.text :body
      t.boolean :requires_login, :default => false
      t.boolean :cacheable,      :default => false
      t.integer :page_layout_id
      t.timestamps
    end
    add_index :pages, :page_layout_id

    create_table :page_layouts do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :page_layouts
    drop_table :pages
    drop_table :file_assets
    drop_table :open_id_authentication_associations
    drop_table :open_id_authentication_nonces
    drop_table :sessions
    drop_table :admins
  end
end
