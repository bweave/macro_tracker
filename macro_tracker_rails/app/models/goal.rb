class Goal < ApplicationRecord
  include ScopedToUser

  attribute :amount, :integer, default: 0

  # TODO: should name be an enum?

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
    exists? ? all : build_for_current_user
  end

  def self.build_for_current_user
    %w[carbs protein fat fiber calories].map { |name| create!(name: name) }
  end
end
