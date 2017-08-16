class CreateBranchIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :branch_ideas do |t|
    	t.string :content
    	t.integer :user_id
    	t.integer :community_id
    	t.integer :root_id 
    	t.timestamps
    end
  end
end
