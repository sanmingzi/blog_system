class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :name,     null: false
      t.string :action,   null: false
      t.string :resource, null: false
      t.boolean :status, default: true
      t.timestamps
    end
  end
end
