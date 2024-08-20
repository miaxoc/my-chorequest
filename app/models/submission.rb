class Submission < ApplicationRecord
  belongs_to :task
  belongs_to :user

  has_one_attached :photo
  enum status: ["pending", "given", "completed"]
end
