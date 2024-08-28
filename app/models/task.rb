class Task < ApplicationRecord
  belongs_to :household
  belongs_to :user, optional: true
  has_many :submissions, dependent: :destroy
  CATEGORIES = ["Cleaning", "Kitchen", "Shopping", "Others"]
  # validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :title, presence: true
  enum frequency: ["daily", "weekly", "monthly"]
end
