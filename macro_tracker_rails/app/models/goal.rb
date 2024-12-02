class Goal < ApplicationRecord
  include ScopedToUser

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
