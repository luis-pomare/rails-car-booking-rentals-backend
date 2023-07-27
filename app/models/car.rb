class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :cost_per_day, presence: true, numericality: { greater_than: 0 }
end
