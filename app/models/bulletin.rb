# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }

  scope :ordered, -> { order(created_at: :desc) }
  scope :published, -> { where(state: :published) }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description state category_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category user]
  end
end
