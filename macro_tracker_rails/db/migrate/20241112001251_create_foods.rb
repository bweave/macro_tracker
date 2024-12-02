class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :calories
      t.decimal :carbs
      t.decimal :protein
      t.decimal :fat
      t.decimal :fiber

      t.timestamps
    end
  end
end
