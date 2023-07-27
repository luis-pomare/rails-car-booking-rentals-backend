class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  has_many :reservations, dependent: :destroy
end
