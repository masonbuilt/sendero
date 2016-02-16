class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :value
      t.string :name

      t.timestamps null: false
    end
  end
end
