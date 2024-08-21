class Household < ApplicationRecord
  belongs_to :user
  has_many :users, dependent: :destroy
  has_many :tasks
  has_many :submissions, through: :tasks
  validates :title, presence: true


end
