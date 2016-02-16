class AddGradeIdToRoute < ActiveRecord::Migration
  def up
  	add_column :routes, :grade_id, :integer, default: nil
  end

  def down
  	remove_column :routes, :grade_id
  end
end
