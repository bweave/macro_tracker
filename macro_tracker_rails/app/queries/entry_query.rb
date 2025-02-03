class EntryQuery
  def self.for_date(date)
    new.for_date(date)
  end

  def for_date(date_range = Date.today.all_day)
    relation
      .where(eaten_at: date_range)
      .order(:mealtime)
      .pluck(columns)
      .map { |row| Result.new(*row) }
      .group_by { |entry| entry.eaten_at.to_date }
      .transform_values { |entries| entries.group_by(&:mealtime) }
  end

  private

  def relation
    Entry.joins(food_entries: :food).where("1=1")
  end

  def columns
    %w[
      entries.id
      entries.mealtime
      entries.eaten_at
      food_entries.servings
      foods.name
      foods.calories
      foods.carbs
      foods.protein
      foods.fat
      foods.fiber
    ]
  end

  Result =
    Struct.new(
      :id,
      :mealtime,
      :eaten_at,
      :servings,
      :name,
      :calories,
      :carbs,
      :protein,
      :fat,
      :fiber
    ) do
      def eaten_at_time
        eaten_at.strftime("%I:%M %p")
      end

      def to_key
        [ "entry", id ]
      end

      def model_name
        ActiveModel::Name.new Entry
      end

      def to_partial_path
        "entries/entry"
      end

      def to_param
        id.to_s
      end
    end
end
