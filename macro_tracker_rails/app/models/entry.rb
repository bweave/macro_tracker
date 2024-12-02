class Entry < ApplicationRecord
  include ScopedToUser

  has_many :food_entries, inverse_of: :entry, dependent: :destroy
  has_many :foods, through: :food_entries

  enum :mealtime, { breakfast: 0, lunch: 1, dinner: 2, snack: 3 }

  validates :eaten_at, presence: true
  validates :mealtime, presence: true

  accepts_nested_attributes_for :food_entries, allow_destroy: true
  accepts_nested_attributes_for :foods

  def self.prototype
    eaten_at = Time.current.beginning_of_hour
    mealtime =
      case eaten_at
      when Time.parse("6AM")..Time.parse("9AM")
        mealtimes[:breakfast]
      when Time.parse("11AM")..Time.parse("1PM")
        mealtimes[:lunch]
      when Time.parse("5PM")..Time.parse("7PM")
        mealtimes[:dinner]
      else
        mealtimes[:snack]
      end

    new(eaten_at:, mealtime:)
  end
end
