class Goal < ApplicationRecord
  include ScopedToUser

  validates :name,
            inclusion: {
              in: %w[carbs protein fat fiber calories]
            },
            uniqueness: {
              scope: :user_id
            }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
