class RemoveIconUrlColumnFromMembers < ActiveRecord::Migration[7.2]
  def change
    remove_column :members, :icon_url, :string, limit: 2083
  end
end
