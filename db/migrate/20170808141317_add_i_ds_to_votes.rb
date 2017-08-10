class AddIDsToVotes < ActiveRecord::Migration[5.0]
  def change
  	add_column :votes, :user_id, :integer
  	add_column :votes, :community_id, :integer
  	add_column :votes, :idea_id, :integer
  	add_index :votes, [:user_id, :created_at]
    add_index :votes, [:community_id, :created_at]
    add_index :votes, [:idea_id, :created_at]
  end
end
