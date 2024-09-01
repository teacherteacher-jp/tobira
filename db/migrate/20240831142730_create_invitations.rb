class CreateInvitations < ActiveRecord::Migration[7.2]
  def change
    create_table :invitations do |t|
      t.integer :inviter_id, null: false
      t.integer :role_id, null: false
      t.string :code, null: false
      t.string :invitee_name, null: false
      t.datetime :used_at

      t.timestamps
    end

    add_index :invitations, :inviter_id
    add_index :invitations, :role_id
    add_index :invitations, :code, unique: true
    add_index :invitations, :used_at
  end
end
