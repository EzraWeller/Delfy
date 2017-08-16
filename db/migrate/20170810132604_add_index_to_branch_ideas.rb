class AddIndexToBranchIdeas < ActiveRecord::Migration[5.0]
  def change
  	add_index :branch_ideas, [:user_id, :created_at]
    add_index :branch_ideas, [:community_id, :created_at]
    add_index :branch_ideas, [:root_id, :created_at]
  end
end
