class CreatePageLayouts < ActiveRecord::Migration
  def self.up
    create_table :page_layouts do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
    add_column :pages, :page_layout_id, :integer
  end

  def self.down
    remove_column :pages, :page_layout_id
    drop_table :page_layouts
  end
end
