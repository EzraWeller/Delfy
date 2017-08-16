class AddBranchIdeaIdToVotes < ActiveRecord::Migration[5.0]
  def change
  	add_column :votes, :branch_idea_id, :integer
  	add_index :votes, [:branch_idea_id, :created_at]
  end
end
