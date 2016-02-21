class AddInfoToRoute < ActiveRecord::Migration
  def up
  	add_column :routes, :info, :text
  end

  def down
  	remove_column :routes, :info
  end
end
