class Household < ApplicationRecord
  belongs_to :user
  has_many :users, dependent: :destroy

  validates :title, presence: true


end
