# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  # Валидации
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validate :image_size

  # Скоуп для сортировки (новые первыми)
  scope :ordered, -> { order(created_at: :desc) }

  private

  def image_size
    return unless image.attached?

    return unless image.byte_size > 5.megabytes

    errors.add(:image, 'не должно превышать 5 МБ')
  end
end
