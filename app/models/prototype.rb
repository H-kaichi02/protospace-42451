class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validate :image_presence

private

def image_presence
  errors.add(:image, "を添付してください") unless image.attached?
end
end
