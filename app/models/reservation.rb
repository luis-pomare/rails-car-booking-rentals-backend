class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :starting_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :car_id, presence: true
end
