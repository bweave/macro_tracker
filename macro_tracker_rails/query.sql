SELECT
    entries.mealtime,
    entries.eaten_at,
    food_entries.servings,
    foods.name,
    foods.calories,
    foods.carbs,
    foods.protein,
    foods.fat,
    foods.fiber
FROM
    entries
INNER JOIN food_entries ON entries.id = food_entries.entry_id
INNER JOIN foods ON food_entries.food_id = foods.id
WHERE
    1 = 1
    AND entries.user_id = 890002738
    AND food_entries.user_id = 890002738
    AND foods.user_id = 890002738;
