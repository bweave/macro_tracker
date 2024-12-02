class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :entries, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def name
    "#{first_name} #{last_name}"
  end
end
