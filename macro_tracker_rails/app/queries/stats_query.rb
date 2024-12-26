class StatsQuery
  def initialize(time_range = Date.today.all_day)
    @time_range = time_range
  end

  def call
    stats = StatsResult.new(*relation.pluck(*columns).first)
    goals = Goal.pluck("LOWER(name)", :amount).to_h.with_indifferent_access
    [ stats, goals ]
  end

  private

  attr_reader :time_range

  def relation
    Entry.includes(food_entries: :food).where(eaten_at: time_range)
  end

  def columns
    [
      Arel.sql("SUM(foods.carbs * food_entries.servings) AS carbs"),
      Arel.sql("SUM(foods.protein * food_entries.servings) AS protein"),
      Arel.sql("SUM(foods.fat * food_entries.servings) AS fat"),
      Arel.sql("SUM(foods.calories * food_entries.servings) AS calories"),
      Arel.sql("SUM(foods.fiber * food_entries.servings) AS fiber")
    ]
  end

  class StatsResult
    attr_reader :carbs, :protein, :fat, :calories, :fiber

    def initialize(carbs, protein, fat, calories, fiber)
      @carbs = carbs || 0
      @protein = protein || 0
      @fat = fat || 0
      @calories = calories || 0
      @fiber = fiber || 0
    end
  end
end
