class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30}, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500 }
end
