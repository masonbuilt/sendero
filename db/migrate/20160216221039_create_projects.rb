class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.integer :route_id

      t.timestamps null: false
    end
  end
end
