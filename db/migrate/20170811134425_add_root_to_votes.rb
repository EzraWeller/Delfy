class AddRootToVotes < ActiveRecord::Migration[5.0]
  def change
  	remove_column :ideas, :root, :boolean
  	add_column :votes, :root, :boolean
  end
end
