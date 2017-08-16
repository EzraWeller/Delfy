class AddRootToIdeas < ActiveRecord::Migration[5.0]
  def change
  	add_column :ideas, :root, :boolean
  end
end
