class CreateLeaderMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :leader_messages do |t|
      t.integer :user_id
      t.integer :community_id
      t.timestamps
    end
  end
end
