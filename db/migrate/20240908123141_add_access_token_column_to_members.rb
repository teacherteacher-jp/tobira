class AddAccessTokenColumnToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :access_token, :string
  end
end
