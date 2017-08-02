class AddLeaderToCommunities < ActiveRecord::Migration[5.0]
  def change
  	add_column :communities, :leader, :integer
  end
end
