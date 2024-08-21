class Household < ApplicationRecord
  belongs_to :user
  has_many :users, dependent: :destroy
  has_many :tasks

  validates :title, presence: true


end
