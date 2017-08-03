class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
    	t.integer :user_id
    	t.integer :community_id

    	t.timestamps
    end
    add_index :memberships, [:user_id, :community_id], unique: true
  end
end
