class AddIdeaToBranchIdeas < ActiveRecord::Migration[5.0]
  def change
  	add_column :branch_ideas, :idea_id, :integer
  	remove_column :branch_ideas, :root_id, :integer
  end
end
