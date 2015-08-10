class CreateCmsTables < ActiveRecord::Migration
  def self.up

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
  end
end
