class DropAndAddMembershipsIndex < ActiveRecord::Migration[5.0]
  def change
  	remove_index :memberships, [:user_id, :community_id]
  	add_index :memberships, [:user_id, :community_id]
  end
end