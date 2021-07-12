class Book < ApplicationRecord
  has_many :comments

  validates :title, presence: true
  validates :description, length: { maximum: 250 }
end
