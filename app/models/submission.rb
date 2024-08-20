class Submission < ApplicationRecord
  belongs_to :task
  belongs_to :user

  has_one_attached :photo
  validates :status, default: 0
  enum status: ["pending", "given", "completed"]
end
