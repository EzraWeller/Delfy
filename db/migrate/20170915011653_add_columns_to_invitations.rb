class AddColumnsToInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :email, :string
  	add_column :invitations, :community_id, :integer
  	add_column :invitations, :access_digest, :string
  end
end