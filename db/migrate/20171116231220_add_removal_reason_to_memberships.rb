class AddRemovalReasonToMemberships < ActiveRecord::Migration[5.0]
  def change
  	add_column :memberships, :removal_reason, :string
  end
end
