class StatsQuery
  Result = Data.define(:date, :carbs, :protein, :fat, :calories, :fiber)

  def initialize(time_range = Date.today.all_day)
    @time_range = time_range
  end

  def call
    stats = relation.pluck(*columns).map { |row| Result.new(*row) }
    goals = Goal.pluck("LOWER(name)", :amount).to_h.with_indifferent_access
    [ stats, goals ]
  end

  private

  attr_reader :time_range

  def relation
    Entry
      .without_user_scope
      .from(Arel.sql("(#{date_range_query}) AS dates"))
      .joins("LEFT JOIN entries ON DATE(entries.eaten_at) = dates.date")
      .joins("LEFT JOIN food_entries ON food_entries.entry_id = entries.id")
      .joins("LEFT JOIN foods ON foods.id = food_entries.food_id")
      .where("entries.user_id = ? OR entries.id IS NULL", Current.user.id)
      .group("dates.date")
  end

  def date_range_query
    ActiveRecord::Base.sanitize_sql_array([
      """
        WITH RECURSIVE dates(date) AS (
          SELECT date(?)
          UNION ALL
          SELECT date(date, '+1 day')
          FROM dates
          WHERE date < date(?)
        )
        SELECT date FROM dates
      """,
      time_range.begin,
      time_range.end
    ])
  end

  def columns
    [
      "dates.date",
      Arel.sql("COALESCE(SUM(foods.carbs * food_entries.servings), 0) AS carbs"),
      Arel.sql("COALESCE(SUM(foods.protein * food_entries.servings), 0) AS protein"),
      Arel.sql("COALESCE(SUM(foods.fat * food_entries.servings), 0) AS fat"),
      Arel.sql("COALESCE(SUM(foods.calories * food_entries.servings), 0) AS calories"),
      Arel.sql("COALESCE(SUM(foods.fiber * food_entries.servings), 0) AS fiber")
    ]
  end
end
