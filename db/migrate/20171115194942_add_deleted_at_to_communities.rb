class AddDeletedAtToCommunities < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :deleted_at, :datetime
    add_index :communities, :deleted_at
  end
end
