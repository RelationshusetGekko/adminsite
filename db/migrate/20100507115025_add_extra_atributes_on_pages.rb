class AddExtraAtributesOnPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :requires_login, :boolean, :default=>false
    add_column :pages, :cacheable, :boolean, :default=>false
  end

  def self.down
    remove_column :pages, :cacheable
    remove_column :pages, :requires_login
  end
end