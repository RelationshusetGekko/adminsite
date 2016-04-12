class CreateAdminUserRoles < ActiveRecord::Migration
  def change
    create_table :adminsite_admin_user_roles do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :adminsite_admin_user_roles, :name, unique: true

    create_table :adminsite_admin_user_roles_users, id: false do |t|
      t.references :admin_user, null: false
      t.references :admin_user_role, null: false
    end
    add_index :adminsite_admin_user_roles_users, :admin_user_id
    add_index :adminsite_admin_user_roles_users, :admin_user_role_id

    Adminsite::AdminUserRole.create [{name: 'admin'}, {name: 'editor'},{name: 'customer'}]
  end
end


