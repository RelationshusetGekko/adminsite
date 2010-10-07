class AddIndexToPages < ActiveRecord::Migration
  def self.up
    add_index :pages, :page_layout_id
  end

  def self.down
    remove_index :pages, :page_layout_id
  end
end