class CreateChannels < ActiveRecord::Migration[7.2]
  def change
    create_table :channels do |t|
      t.string :original_id, null: false
      t.string :category_id
      t.string :name, null: false
      t.integer :type_id, null: false
      t.integer :position, null: false
      t.timestamps
    end

    add_index :channels, :original_id, unique: true
    add_index :channels, :category_id
    add_index :channels, :type_id
    add_index :channels, :position
  end
end
