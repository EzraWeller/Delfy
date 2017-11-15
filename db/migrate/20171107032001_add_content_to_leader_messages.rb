class AddContentToLeaderMessages < ActiveRecord::Migration[5.0]
  def change
  	add_column :leader_messages, :content, :string
  end
end
