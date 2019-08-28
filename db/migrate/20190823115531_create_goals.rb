class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :priority, null: false
      t.date :due_date
      t.boolean :complete, default: false, null: false

      t.timestamps
    end
  end
end
