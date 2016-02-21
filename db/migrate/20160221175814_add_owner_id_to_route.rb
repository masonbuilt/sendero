class AddOwnerIdToRoute < ActiveRecord::Migration
  def up
  	add_column :routes, :owner_id, :integer
  end

  def down
  	remove_column :routes, :owner_id
  end
end
