class CreateRolePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_permissions do |t|
      t.references :role,       null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
