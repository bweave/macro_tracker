class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.integer :mealtime, default: 0, null: false
      t.datetime :eaten_at

      t.timestamps
    end
  end
end
