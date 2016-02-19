class AddStatusToProject < ActiveRecord::Migration
  def up
  	add_column :projects, :status, :string, default: "active"
  end

  def down
  	remove_column :projects, :status
  end
end
