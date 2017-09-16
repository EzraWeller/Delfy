class AddUserIdToInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :user_id, :integer
  end
end
