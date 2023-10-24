class Group < ApplicationRecord
  has_one_attached :avatar
  validates :title, :description, presence: true

  has_many :members
end
