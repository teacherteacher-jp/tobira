class CreateRoleChannels < ActiveRecord::Migration[7.2]
  def change
    create_table :role_channels do |t|
      t.references :role, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.timestamps
    end

    add_index :role_channels, [ :role_id, :channel_id ], unique: true
  end
end
