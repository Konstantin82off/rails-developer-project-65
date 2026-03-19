# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  # Валидации
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validate :image_size

  # Скоупы
  scope :ordered, -> { order(created_at: :desc) }
  scope :published, -> { where(state: :published) }

  # AASM - конечный автомат для управления состояниями
  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    # Отправка на модерацию
    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    # Публикация (только после модерации)
    event :publish do
      transitions from: :under_moderation, to: :published
    end

    # Отклонение (требует доработки)
    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    # Отправка в архив (из любого состояния, кроме архива)
    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  private

  def image_size
    return unless image.attached?

    return unless image.byte_size > 5.megabytes

    errors.add(:image, 'не должно превышать 5 МБ')
  end
end
