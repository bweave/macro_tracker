class FoodEntry < ApplicationRecord
  include ScopedToUser

  belongs_to :food
  belongs_to :entry

  validates :servings, presence: true, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :food
end
