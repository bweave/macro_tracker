class AddUniqIndexToGoals < ActiveRecord::Migration[8.0]
  def change
    add_index :goals, %i[name user_id], unique: true
  end
end
