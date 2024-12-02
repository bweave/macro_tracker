class CreateFoodEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :food_entries do |t|
      t.references :food, null: false, foreign_key: true
      t.references :entry, null: false, foreign_key: true
      t.integer :servings, null: false, default: 1

      t.timestamps
    end
  end
end
