class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
    	t.timestamps
    	t.string :name
    	t.string :description
    end
  end
end
