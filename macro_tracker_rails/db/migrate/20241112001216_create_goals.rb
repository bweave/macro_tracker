class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :amount

      t.timestamps
    end
  end
end
