class DropColumnsFromMemberships < ActiveRecord::Migration[5.0]
  def change
  	remove_column :memberships, :join_digest
  	remove_column :memberships, :activated
  end
end
