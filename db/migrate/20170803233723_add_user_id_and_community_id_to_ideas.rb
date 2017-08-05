class AddUserIdAndCommunityIdToIdeas < ActiveRecord::Migration[5.0]
  def change
  	add_column :ideas, :user_id, :integer
  	add_column :ideas, :community_id, :integer
  	add_index :ideas, [:user_id, :created_at]
    add_index :ideas, [:community_id, :created_at]
  end
end
