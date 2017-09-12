class AddMembershipSettingToCommunities < ActiveRecord::Migration[5.0]
  def change
  	add_column :communities, :membership_setting, :string
  end
end
