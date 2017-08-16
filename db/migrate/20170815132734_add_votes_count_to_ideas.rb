class AddVotesCountToIdeas < ActiveRecord::Migration[5.0]
  def change
  	add_column :ideas,        :votes_count, :integer, default: 0
  	add_column :branch_ideas, :votes_count, :integer, default: 0
  end
end