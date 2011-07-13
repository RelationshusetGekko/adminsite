class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string     :email
      t.string     :password_hash
      t.string     :password_salt
      t.string     :public_key
      t.string     :referral
      t.datetime   :permission_given_at
      t.datetime   :unsubscribed_at

      t.timestamps
    end

    add_index :profiles, :email
    add_index :profiles, :public_key, :unique => true
  end

  def self.down
    drop_table :profiles
  end
end