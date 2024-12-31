class Goal < ApplicationRecord
  include ScopedToUser

  attribute :amount, :integer, default: 0

  validates :name,
            inclusion: {
              in: %w[carbs protein fat fiber calories]
            },
            uniqueness: {
              scope: :user_id
            }
  validates :amount,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: -1
            }

  def self.for_current_user
    exists? ? all : prototype
  end

  def self.prototype
    %w[carbs protein fat fiber calories].map { |name| create!(name: name) }
  end
end
