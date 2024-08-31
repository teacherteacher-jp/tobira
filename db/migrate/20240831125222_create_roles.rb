class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :original_id, null: false
      t.string :name, null: false
      t.boolean :usable, null: false, default: false

      t.timestamps
    end

    add_index :roles, :original_id, unique: true
    add_index :roles, :usable
  end
end
