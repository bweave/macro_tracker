class EntryQuery
  def self.for_date(date)
    new.for_date(date)
  end

  def for_date(date)
    relation
      .where(eaten_at: date.all_day)
      .order(:mealtime)
      .pluck(columns)
      .map(&method(:to_struct))
      .group_by(&:mealtime)
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

  def to_struct(raw_data)
    EntryQueryResult.new(*raw_data)
  end

  EntryQueryResult =
    Struct.new(
      :id,
      :mealtime,
      :eaten_at_datetime,
      :servings,
      :name,
      :calories,
      :carbs,
      :protein,
      :fat,
      :fiber
    ) do
      def eaten_at
        eaten_at_datetime.strftime("%I:%M %p")
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
