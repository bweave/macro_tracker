class MacroCalculator
  include ActiveModel::Model
  include ActiveModel::Attributes

  ACTIVITY_LEVELS = {
    sedentary: 1.2,
    lightly_active: 1.375,
    moderately_active: 1.55,
    very_active: 1.725
  }.freeze

  GOALS = %w[weight_loss weight_gain weight_maintenance].freeze

  MACRO_CALORIES = { protein: 4, carbs: 4, fats: 9 }.freeze

  attribute :gender, :string
  validates :gender, presence: true, inclusion: { in: %w[male female] }

  attribute :height, :integer
  validates :height, presence: true, numericality: { greater_than: 0 }

  attribute :height_unit, :string
  validates :height_unit, presence: true, inclusion: { in: %w[cm in] }

  attribute :weight, :integer
  validates :weight, presence: true, numericality: { greater_than: 0 }

  attribute :weight_unit, :string
  validates :weight_unit, presence: true, inclusion: { in: %w[kg lb] }

  attribute :age, :integer
  validates :age, presence: true, numericality: { greater_than: 0 }

  attribute :activity_level, :string
  validates :activity_level, presence: true, inclusion: { in: ACTIVITY_LEVELS.keys }

  attribute :goal, :string
  validates :goal, presence: true, inclusion: { in: GOALS }

  def daily_macros
    { calories:, protein: protein_grams, carbs: carb_grams, fat: fat_grams }
  end

  def calories
    @calories ||= (tdde + weight_goal_adjustment).round
  end

  def protein_grams
    (weight_pounds * 0.65).round
  end

  def fat_grams
    (fat_calories / 9).round
  end

  def carb_grams
    (carb_calories / 4).round
  end

  private

  def protein_calories
    protein_grams * 4
  end

  def fat_calories
    calories * 0.3
  end

  def carb_calories
    calories - fat_calories - protein_calories
  end

  def tdde # total daily energy expenditure
    @tdde ||= (bmr * ACTIVITY_LEVELS[activity_level.to_sym]).round
  end

  def bmr # basal metabolic rate
    (66 + (6.23 * weight_pounds) + (12.7 * height_inches) - (6.8 * age)).round
  end

  def weight_pounds
    weight_unit == "lb" ? weight : weight * 2.20462
  end

  def height_inches
    height_unit == "in" ? height : height * 2.54
  end

  def weight_goal_adjustment
    case goal
    when "weight_loss"
      -tdde * 0.15
    when "weight_gain"
      tdde * 0.15
    else
      0
    end
  end

  def macro_percentages
    if goal == "weight_loss"
      { protein: 0.4, carbs: 0.4, fats: 0.2 }
    else
      { protein: 0.4, carbs: 0.3, fats: 0.3 }
    end
  end
end
