json.extract! food, :id, :name, :calories, :carbs, :protein, :fat, :fiber, :created_at, :updated_at
json.url food_url(food, format: :json)
