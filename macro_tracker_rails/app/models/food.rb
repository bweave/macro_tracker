class Food < ApplicationRecord
  include ScopedToUser

  has_many :food_entries, dependent: :destroy
  has_many :entries, through: :food_entries

  validates :name, presence: true
  validates :calories,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than: BigDecimal(10**4)
            },
            format: {
              with: /\A\d{1,4}(\.\d{1,2})?\z/
            }
  validates :carbs,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than: BigDecimal(10**4)
            },
            format: {
              with: /\A\d{1,4}(\.\d{1,2})?\z/
            }
  validates :protein,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than: BigDecimal(10**4)
            },
            format: {
              with: /\A\d{1,4}(\.\d{1,2})?\z/
            }
  validates :fat,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than: BigDecimal(10**4)
            },
            format: {
              with: /\A\d{1,4}(\.\d{1,2})?\z/
            }
  validates :fiber,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than: BigDecimal(10**4)
            },
            format: {
              with: /\A\d{1,4}(\.\d{1,2})?\z/
            }
end
