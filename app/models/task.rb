class Task < ApplicationRecord
  belongs_to :household
  belongs_to :user
  has_many :submissions

  CATEGORIES = ["Vacuuming", "Kitchen", "Shopping", "5 minutes", "20 minutes", "Big Tasks"]
  validates :category, presence: true, inclusuion: { in: CATEGORIES }
  validates :title, presence: true
  validates :frequency, presence: true
end
