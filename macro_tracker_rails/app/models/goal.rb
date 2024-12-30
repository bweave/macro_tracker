class Goal < ApplicationRecord
  include ScopedToUser

  validates :name,
            inclusion: {
              in: %w[carbs protein fat fiber calories]
            },
            uniqueness: {
              scope: :user_id
            }
  validates :amount, presence: true, numericality: { greater_than: -1 }

  def self.for_current_user
    exists? ? all : prototype
  end

  def self.prototype
    %w[carbs protein fat fiber calories].map do |name|
      create!(name: name, amount: 0)
    end
  end
end
